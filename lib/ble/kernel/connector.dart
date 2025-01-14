part of blelib;

class BleConnector {
  ConnectionStateChangeCallback? connectionChangeHandler;

  bool bSwitchingMutex = false;
  bool bConnectingMutex = false;
  static int reconnectIntervalSeconds = 3;
  static int connectTimeout = 12;
  bool shouldReconnect = false;

  factory BleConnector() => _getInstance();
  static BleConnector get instance => _getInstance();
  static BleConnector? _instance;
  static BleConnector _getInstance() {
    _instance ??= BleConnector._internal();
    return _instance!;
  }

  BleConnector._internal() {
    Future.delayed(
        Duration(seconds: reconnectIntervalSeconds), reconnectProcess);
  }
  Future<bool> _connectDevice(BluetoothDevice device) async {
    ekLog("ble: _connect");
    ekLog('设备 $device');
    try {
      await device.connect(
          autoConnect: false, timeout: Duration(seconds: connectTimeout));
    } catch (e) {
      ekLog('ble: connection error.....');
      ekLog('ble: ${e.toString()}');

      if (e.runtimeType == TimeoutException) {
        ekLog('ble: timeout exception..');
        //await _disconnectDevice(device);
      } else if (e.runtimeType == PlatformException) {
        PlatformException pe = e as PlatformException;
        if (pe.code == 'already_connected') {
          ekLog('ble: already_connected exception..');
          // 之前已经连接上了，就继续往下走
          return true;
        }
      } else {
        ekLog('ble: other connect exception..');
      }

      return false;
    }
    return true;
  }

  void listenBleConnectionState(ConnectionStateChangeCallback dataHandler) {
    connectionChangeHandler = dataHandler;
  }

  Future<dynamic> _disconnectDevice(BluetoothDevice device) async {
    ekLog("ble: _disconnect");
    try {
      return await device.disconnect();
    } catch (e) {
      ekLog('ble: disconnect error...');
      return;
    }
  }

  Future<List<BluetoothService>> _deviceToDiscoverServices(
      BluetoothDevice device) async {
    try {
      return await device.discoverServices();
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> connectDevice(BleDevice? device) async {
    if (bConnectingMutex) return false;
    bConnectingMutex = true;
    try {
      if (device == null) {
        ekLog('ble:device is null');
        return false;
      }

      bool isBleOn = await BleManager.instance.isBleOn();
      if (!isBleOn) return false;

      var connectedDevices = getConnectedDevices();
      ekLog('connectedDevices Len ${connectedDevices.length}');
      if (connectedDevices.isNotEmpty) {
        ekLog('ble: connected len > 0......');
        for (var deviceItem in connectedDevices) {
          ekLog('connected name: ${deviceItem.platformName}');
          ekLog('connected id: ${deviceItem.remoteId}');
          if (deviceItem.remoteId.toString() == device.deviceId) {
            // 已连接

            device.isClosing = false;

            final s = await device.device!.connectionState.first;
            if (s == BluetoothConnectionState.connected) {
              ekLog('ble: directly discover services..');
              device.device = deviceItem;
              discoverServices(device);

              return true;
            }
          } else {
            ekLog('找到多余设备');
          }
        }
      }

      if (Config.gShouldClearGattCache && !device.isScanAvailable.value) {
        ekLog('ble: scan available is false');
        await BleScanner.instance.startScan();
        return false;
      }

      if (device.device == null) {
        ekLog('ble:device.device is null');
        device.reset();
        return false;
      }

      if (BleScanner.instance.shouldRescan) {
        ekLog('ble: should rescan = true');
        return false;
      }

      if (!device.isListeningConn) {
        await _listenBlueConnectionState(device);
        device.isListeningConn = true;
      }

      ekLog('ble: =========connecting.......');

      //lockModel.setCurrentDevice(device);
      device.isClosing = false;
      bool res = await _connectDevice(device.device!);
      //if (!res) {
      //isConnecting.value = false;
      ekLog('ble: connection done...');
      if (res == false) {
        ekLog('ble: connect call return false');
      }

      return true;
      //}
    } catch (e) {
      ekLog('....catch exception when connecting....');
      ekLog(e);
    } finally {
      bConnectingMutex = false;
    }

    return false;
  }

  List<BluetoothDevice> getConnectedDevices() {
    return FlutterBluePlus.connectedDevices;
  }

  switchToDisconnected(BleDevice device) async {
    if (device.charListener != null) {
      await device.charListener!.cancel();
    }
    if (device.connectionListener != null) {
      await device.connectionListener!.cancel();
    }

    device.isListeningConn = false;
    device.isListeningChar = false;

    device.isScanAvailable.value = false;
    device.lastScan = null;
  }

  _listenBlueConnectionState(BleDevice device) {
    ekLog('ble: listen conn...');
    if (device.device == null) return;
    device.connectionListener = device.device!.connectionState
        .listen((BluetoothConnectionState state) async {
      switch (state) {
        case BluetoothConnectionState.connected:
          {
            Config.gReconnectDeviceId = '';
            ekLog(
                'ble: conn-listend ================ connected ${device.device!.platformName}============= ');

            if (device.bleState.value == BluetoothConnectionState.connected) {
              ekLog('ble: listen twice connected state');
              return;
            }

            if (device.isClosing) return;

            device.bleState.value = BluetoothConnectionState.connected;

            await discoverServices(device);

            await BleDataChannel.instance.listenMtu(device);
            if (connectionChangeHandler != null) {
              connectionChangeHandler!(ConnectionState.connected, device);
            }

            break;
          }
        case BluetoothConnectionState.disconnected:
          {
            ekLog("ble: conn-listend --> disconnected..............");

            if (device.bleState.value ==
                BluetoothConnectionState.disconnected) {
              ekLog('ble: ble: listen twice disconnected state');
              return;
            }

            ekLog('ble: conn-listen --> to disconnect device...');

            device.bleState.value = BluetoothConnectionState.disconnected;
            await switchToDisconnected(device);

            await BleDataChannel.instance.cancelListenMtu(device);

            ekLog("ble: conn-listend --> disconnected done..............");

            if (connectionChangeHandler != null) {
              connectionChangeHandler!(ConnectionState.disconnected, device);
            }
            break;
          }
        // ignore: deprecated_member_use
        case BluetoothConnectionState.connecting:
          break;
        // ignore: deprecated_member_use
        case BluetoothConnectionState.disconnecting:
          break;
      }
    });
  }

  void reconnectProcess() async {
    if (Config.gAutoReconnect) {
      ekLog('ble: auto reconnect');
      WorkingDevice bondModel = Get.find<WorkingDevice>();

      BleDevice? lostDevice;
      if (Config.gOnlyReconnectLast) {
        lostDevice = bondModel.getLastUsingDevice();
        if (lostDevice != null &&
            (lostDevice.bleState.value == BluetoothConnectionState.connected)) {
          shouldReconnect = false;
          lostDevice = null;
        }
        if (lostDevice != null && lostDevice.isScanAvailable.value == false) {
          shouldReconnect = false;
          lostDevice = null;
        }
      } else if (Config.gReconnectDeviceId.isEmpty) {
        lostDevice = bondModel.getLostDevice();
        //ekLog("ble: get lost when reconnect device ${lostDevice?._localName}");
      } else {
        ekLog("ble: reconnect after rename");
        lostDevice = bondModel.getByIdString(Config.gReconnectDeviceId);
        if (Config.gReconnectDeviceName.isNotEmpty &&
            lostDevice != null &&
            lostDevice.device?.platformName != Config.gReconnectDeviceName) {
          lostDevice = null;
        }
      }

      if (lostDevice != null && lostDevice.isScanAvailable.value) {
        shouldReconnect = true;
      } else {
        ekLog(
            'lost ${lostDevice?.localName} isScanAvailable ${lostDevice?.isScanAvailable.value}');
      }

      if (shouldReconnect && lostDevice != null) {
        ekLog('ble:reconnect processing...');
        connectDevice(lostDevice);
        shouldReconnect = false;
      }
    }

    Future.delayed(
        Duration(seconds: reconnectIntervalSeconds), reconnectProcess);
  }

  Future discoverServices(BleDevice device) async {
    ekLog('discoverServices....');

    if (device.device == null) {
      return;
    }

    List<BluetoothService> services;
    try {
      services = await _deviceToDiscoverServices(device.device!);
    } catch (e) {
      rethrow;
    }

    ekLog("ble:discovering services....");

    var serviceUuidList = Config.gBleServiceUuidMap.keys.toList();
    for (var service in services) {
      for (var s in serviceUuidList) {
        if (service.uuid.str128.toLowerCase() != s.toLowerCase()) {
          continue;
        }

        for (BluetoothCharacteristic c in service.characteristics) {
          var charaList = Config.gBleServiceUuidMap[s];
          if (charaList == null) continue;
          if (c.uuid.str128.uuidInList(charaList)) {
            device.allCharacteristic[service.uuid.str128 + c.uuid.str128] = c;
            BleDataChannel.instance.listenCharacteristicValue(c);
          }
        }
      }

      if (service.uuid.str128.uuidInList(Config.getAllServiceUuids())) {
        ekLog("---service is fff0---");

        var characteristics = service.characteristics;
        for (BluetoothCharacteristic c in characteristics) {
          ekLog("----BluetoothCharacteristicUUID-->${c.uuid}");
          if (c.uuid.str128.uuidInList(Config.getAllCharacteristicUuids())) {
            for (final config in Config.configList) {
              if (c.uuid.str128.toLowerCase() ==
                  config.writeCharacterUuid.toLowerCase()) {
                device.characteristic = c;
                break;
              } else if (c.uuid.str128.toLowerCase() ==
                  config.notifyCharacterUuid.toLowerCase()) {
                device.notifyCharacteristic = c;
                BleDataChannel.instance
                    .characteristicSetNotify(device)
                    .then((value) {
                  WorkingDevice lockModel = Get.put(WorkingDevice());
                  device.connectTimestamp =
                      DateTime.now().millisecondsSinceEpoch ~/ 1000;
                  lockModel.addOrUpdate(device);
                });
              }
            }

            ekLog("====connected===============");
          }
        }

        break;
      }
    }
  }

  Future<bool> switchToDevice(BleDevice? device) async {
    if (bSwitchingMutex) return false;
    bSwitchingMutex = true;

    try {
      WorkingDevice workingDevice = Get.find();
      var connectedDevice = workingDevice.getConnectedDevice();

      var oldAutoReconnect = Config.gAutoReconnect;
      if (connectedDevice != null && connectedDevice != device) {
        // 已有其他设备在连接
        ekLog('ble: disconnect other devcie before connecting.....');
        Config.gAutoReconnect = false;
        if (connectedDevice.bleState.value ==
            BluetoothConnectionState.disconnected) {
          return false;
        }
        await disconnectDevice(connectedDevice);

        ekLog('ble: connect after disconnect.....');
        await connectDevice(device);
        Config.gAutoReconnect = oldAutoReconnect;
      } else {
        await connectDevice(device);
      }
    } finally {
      bSwitchingMutex = false;
    }

    return true;
  }

  Future<void> disconnectDevice(BleDevice device) async {
    ekLog('to disconnect device 1');

    if (device.device == null) {
      return;
    }

    if (device.bleState.value == BluetoothConnectionState.disconnected) {
      return;
    }

    device.isClosing = true;
    await _disconnectDevice(device.device!);
    ekLog('ble: disconnect done..');
  }
}
