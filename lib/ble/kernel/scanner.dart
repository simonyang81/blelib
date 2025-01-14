part of blelib;

typedef ScanResultHandler = void Function(List<ScanResult>? datas);

class BleScanner {
  bool isStartScan = false;
  static int rescanIntervelSeconds = 1;
  bool shouldRescan = false;
  RxBool isScanning = false.obs;
  static int scanTimeout = 7;

  ScanModel scanModel = Get.put(ScanModel());
  WorkingDevice lockModel = Get.put<WorkingDevice>(WorkingDevice());

  StreamSubscription<List<ScanResult>>? scanResultListener;

  late Timer reconnectionTimer;
  factory BleScanner() => _getInstance();
  static BleScanner get instance => _getInstance();
  static BleScanner? _instance;
  BleScanner._internal() {
    _listenScanningState();
    reconnectionTimer =
        Timer.periodic(Duration(seconds: rescanIntervelSeconds), rescanProcess);
  }
  static BleScanner _getInstance() {
    _instance ??= BleScanner._internal();
    return _instance!;
  }

  Future<bool> startScan() async {
    bool isBleOn = await BleManager.instance.isBleOn();
    bool isGPSOn = await GPSManager.instance.isGPSOn();
    if (isBleOn && isGPSOn) {
      return _startScan(scanResultHandler, timeout: scanTimeout);
    }

    return false;
  }

  _startScan(ScanResultHandler dataHandler, {int timeout = 7}) {
    ekLog("ble: _scan");
    ekLog('ble: isScanning=$isScanning');
    if (!isScanning.value) {
      ekLog('to scanning');
      FlutterBluePlus.startScan(
        androidScanMode: AndroidScanMode.lowLatency,
        timeout: Duration(seconds: timeout),
        //withServices: stringToGuidList(Config.getAllScanFilterUuids()),
      );

      // 只监听一次
      scanResultListener ??= FlutterBluePlus.scanResults.listen(dataHandler);

      return true;
    }
    return false;
  }

  _stopScan() async {
    ekLog("ble:_stopScan");
    await FlutterBluePlus.stopScan();
  }

  ProductConfig? filterPrefix(List<ProductConfig> configList,
      List<String> prefixList, String deviceName) {
    int configIndex = deviceName.startWithInList(prefixList);
    if (configIndex != -1) {
      return configList.elementAt(configIndex);
    } else {
      return null;
    }
  }

  ProductConfig? filterScanWithUuid(List<ProductConfig> configList,
      String advServiceUuid, List<String> scanFilterUuids) {
    int uuidIndex = advServiceUuid.getScanFilterUuidIndex(scanFilterUuids);
    if (uuidIndex == -1) return null;

    return configList.elementAt(uuidIndex);
  }

  // uuid和前缀匹配，两种模式是AND的关系
  // 参数为空时，则表示忽略该匹配条件
  ProductConfig? filterDevice(List<Guid> advServiceUuids, String deviceName) {
    if (advServiceUuids.isEmpty || advServiceUuids[0].toString().isEmpty) {
      return null;
    }
    String advUuid = advServiceUuids[0].toString();
    if (Platform.isIOS && Config.needAppendAdvUuid == true) {
      advUuid = appendAdvUuidForIos(advUuid);
    }

    for (var config in Config.configList) {
      //  不能两个参数都为空
      if ((config.prefix == null || config.prefix!.isEmpty) &&
          (config.scanUuid == null || config.scanUuid!.isEmpty)) continue;

      if (config.prefix == null || config.prefix!.isEmpty) {
        if (advUuid == config.scanUuid) return config;
        continue;
      }

      if (config.scanUuid == null || config.scanUuid!.isEmpty) {
        if (deviceName.startsWith(config.prefix!)) return config;
        continue;
      }

      if (deviceName.startsWith(config.prefix!) && advUuid == config.scanUuid) {
        return config;
      }
    }

    return null;
  }

  void scanResultHandler(List<ScanResult>? results) {
    //eLog('scan callback....');

    if (results == null) return;
    bool hit = false;

    //print('bls: result = $results');
    for (ScanResult r in results) {
      ProductConfig? productConfig =
          filterDevice(r.advertisementData.serviceUuids, r.device.platformName);

      if (productConfig != null) {
        //print('bls: scan find ${Config.gBleDevicePrefix}.....');
        ScanModel scanModel = Get.put(ScanModel());
        BleDevice? curDevice = scanModel.getById(r.device.remoteId);
        ekLog('====当前设备$curDevice');
        if (curDevice == null) {
          // 已扫描列表中未出现，则从已绑定列表中获取
          WorkingDevice lockModel = Get.put(WorkingDevice());
          curDevice = lockModel.getById(r.device.remoteId);
          if (curDevice != null) {
            ekLog('====in bind list: ${r.device.platformName}');
            var rawDeviceName = curDevice.deviceRawName();

            // if (rawDeviceName.isNotEmpty &&
            //     rawDeviceName.startWithInList(Config.getAllPrefix()) != -1 &&
            //     rawDeviceName != r.device.platformName) {
            if (rawDeviceName.isNotEmpty &&
                rawDeviceName.startWithInList(Config.getAllPrefix()) != -1 &&
                rawDeviceName != r.advertisementData.advName) {
              curDevice.setDeviceRawName(r.device.platformName);
              curDevice.localName = r.advertisementData.advName;

              ekLog('====scan name mismatch raw name......');
              ekLog('====raw name = $rawDeviceName');
              ekLog('====scan name = ${r.device.platformName}');
            }
          }

          var count = lockModel.count();
          ekLog('====bind list count:$count');

          ekLog('scan id:${r.device.remoteId}');
          if (curDevice != null) {
            ekLog('==== in bind list isConnnected: ${curDevice.bleState}');
          }

          if (curDevice != null) {
            // 存在于已绑定列表中，所以需要重新连接
            BleConnector.instance.shouldReconnect = true;

            // 防止ios版本为空，所以发现即赋值
            curDevice.device = r.device;
            ekLog('bls: shouldreconnect set true');
          }
        }

        if (curDevice == null) {
          // 是一个全新发现的设备
          curDevice = BleDevice(r.device);

          curDevice.isScanAvailable.value = true;
          curDevice.localName = r.advertisementData.advName;
          scanModel.add(curDevice);
        } else {
          // 已存在已扫描列表或绑定列表中
          curDevice.isScanAvailable.value = true;
          curDevice.localName = r.advertisementData.advName;
        }

        curDevice.lastScan = DateTime.now();

        curDevice.rssi = r.rssi;
        curDevice.productConfig = productConfig;

        if (r.advertisementData.serviceUuids.isNotEmpty) {
          var advUuid = r.advertisementData.serviceUuids[0].str;
          if (Platform.isIOS) {
            advUuid = appendAdvUuidForIos(advUuid);
          }
          //curDevice.scanFilterServiceUuid = advUuid;
        }

        if (Config.autoSortByRSSI) {
          scanModel.sortByRSSI();
        }

        shouldRescan = false;
        hit = true;
      }
    }

    // if (hit && Platform.isAndroid) {
    //   //stopScan();
    // }

    checkScanAvailable();

    // eLog('扫描处理完毕');
  }

  Future<void> rescanProcess(Timer? timer) async {
    if (!Config.gAutoRescan) return;

    // if (lockModel.isAnyDeviceConnecting()) {
    //   ekLog("ble: has device is connecting....");
    //   return;
    // }

    if (Config.gAutoRescanForce == false) {
      if (lockModel.getConnectedDevice() != null) return;
    }

    if (!isScanning.value) {
      ekLog('ble:rescan process....');
      startScan();
    }
  }

  Future<void> stopScan() async {
    await _stopScan();
    isStartScan = false;
  }

  void checkScanAvailable() {
    ScanModel scanModel = Get.find();
    WorkingDevice workingDevice = Get.find();

    for (var item in scanModel.scanList) {
      if (item.isScanAvailable.value == true &&
          item.bleState.value == BluetoothConnectionState.disconnected &&
          item.lastScan != null &&
          item.lastScan!.difference(DateTime.now()).inSeconds.abs() >
              scanTimeout) {
        item.lastScan = null;
        item.isScanAvailable.value = false;
      }
    }

    for (var item in workingDevice.bindDevices) {
      if (item.isScanAvailable.value == true &&
          item.bleState.value == BluetoothConnectionState.disconnected &&
          item.lastScan != null &&
          item.lastScan!.difference(DateTime.now()).inSeconds.abs() >
              scanTimeout) {
        item.lastScan = null;
        item.isScanAvailable.value = false;
      }
    }
  }

  _listenScanningState() {
    FlutterBluePlus.isScanning.listen((bool event) {
      isScanning.value = event;
      ekLog('ble: new scanning state = $event');
    });
  }
}
