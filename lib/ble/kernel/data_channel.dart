part of blelib;

class BleDataChannel {
  SegmentBuf segmentBuf = SegmentBuf();

  StreamSubscription<int>? mtuListenner;

  DataReceiverCallback? dataRcvHandler; // 业务数据（通用协议+私用协议）回调，数据格式需要自行解析
  DataReceiverCallback? dataHandler; // 业务数据（通用协议+私用协议）回调，数据格式需要自行解析
  CommonProtoReceiver commonProtoReceiver = CommonProtoReceiver();

  factory BleDataChannel() => _getInstance();
  static BleDataChannel get instance => _getInstance();
  static BleDataChannel? _instance;
  BleDataChannel._internal();
  static BleDataChannel _getInstance() {
    _instance ??= BleDataChannel._internal();
    return _instance!;
  }

  void setCallbackReceiver(BleCommonRecvInterface bleRecvInterface) {
    commonProtoReceiver.setCallbackReceiver(bleRecvInterface);
  }

  void listenBleReceiverData(DataReceiverCallback dataHandler) {
    BleDataChannel.instance.dataRcvHandler = dataHandler;
  }

  Future<List<int>> _characteristicToReadValue(
      BluetoothCharacteristic characteristic) async {
    ekLog("_read");
    return await characteristic.read();
  }

  Future<void> cancelListenMtu(BleDevice device) async {
    await mtuListenner?.cancel();
  }

  Future<void> listenMtu(BleDevice device) async {
    if (device.device == null) return;
    try {
      // Future<int> requestMtu = device.device!.requestMtu(20);

      Stream<int> stream = device.device!.mtu;
      mtuListenner = stream.listen((data) {
        ekLog("mtu  Stream 收到$data");
        Config.gMtu = data - 3;
      }, onDone: () {
        ekLog("mtu Stream done ");
      }, onError: (error) {
        ekLog("mtu Stream error");
        Config.gMtu = 20;
      });
    } catch (e) {
      ekLog(e);
      // Handle error...
    }
  }

  Future<int> setMtu(BleDevice device, int size) async {
    if (device.device == null) return 0;

    try {
      // Future<int> requestMtu = device.device!.requestMtu(20);
      ekLog("start set mtu ");
      int mtuResult = await device.device!.requestMtu(size);
      ekLog(" Stream result 回复 requestMtu$mtuResult");
      return mtuResult;
    } catch (e) {
      ekLog(e);
      // Handle error...
      return 0;
    }
  }

  void readValue(BleDevice device) {
    if (device.characteristic == null) {
      ekLog("read value when char is null.....!!!!");
      return;
    }
    _characteristicToReadValue(device.characteristic!).then((value) {
      ekLog("read value=$value");
    });
  }

  Future writeValueByUuid(BleDevice device, String serviceUuid,
      String charaUuid, List<int> data) async {
    String keyUuid = serviceUuid + charaUuid;
    var chara = device.allCharacteristic[keyUuid];
    if (chara == null) return;
    try {
      await _characteristicToWriteValue(chara, data).then((value) {
        //ekLog('write: $value');
      });
    } catch (e) {
      ekLog('ble char write error');
      ekLog(e.toString());
    }
  }

  Future writeValue(List<int> list, BleDevice device) async {
    //eLog('ready write$list');
    if (device.characteristic == null) {
      ekLog('write value when char is null !!!!!!!!!!!!!!');
      return;
    }
    try {
      await _characteristicToWriteValue(device.characteristic!, list)
          .then((value) {
        //ekLog('write: $value');
      });
    } catch (e) {
      ekLog('ble write error');
      ekLog(e.toString());
    }
  }

  Future listenCharacteristicValue(BluetoothCharacteristic c) async {
    _listenCharacteristicValue(c, (data) {
      if (data == null || data.isEmpty) return;
      ekLog('chara ${c.uuid} receive: $data');
    });
  }

  Future characteristicSetNotify(BleDevice device) async {
    if (device.notifyCharacteristic == null) {
      ekLog('set notify when char is null....!!!!');
      return;
    }
    ekLog('char-notify=${device.notifyCharacteristic}');
    try {
      await device.notifyCharacteristic!.setNotifyValue(true);
    } catch (e) {
      errLog('e: $e');
      return;
    }

    if (device.isListeningChar) return;
    if (device.device == null) return;
    device.isListeningChar = true;
    ekLog('ble: listen char....');

    device.charListener =
        _listenCharacteristicValue(device.notifyCharacteristic!, (data) {
      //eLog("notify=>>>>>>$data");

      handleRespond(device.device!, data);

      // MyBleDevice.bleNotifyData = data!;
      if (data == null || data.isEmpty) {
        ekLog("data=null>>>>>>");
        return;
      } else {}
    });
  }

  StreamSubscription<List<int>> _listenCharacteristicValue(
      BluetoothCharacteristic characteristic,
      CharacteristicHandler characteristicHandler) {
    return characteristic.onValueReceived.listen(characteristicHandler);
  }

  Future<void> _characteristicToWriteValue(
      BluetoothCharacteristic characteristic, List<int> list,
      {bool withoutResponse = false}) async {
    try {
      var result =
          await characteristic.write(list, allowLongWrite: true, withoutResponse: withoutResponse);
      return result;
    } catch (e) {
      return;
    }
  }
}
