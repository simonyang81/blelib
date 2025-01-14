part of blelib;

enum BleDeviceState { disconnected, connected, none }

class BleDevice {
  // 应用层所持有的蓝牙状态，是底层库持有蓝牙状态的影子
  Rx<BluetoothConnectionState> bleState =
      BluetoothConnectionState.disconnected.obs;
  var isScanAvailable = false.obs;
  bool isListeningChar = false;
  bool isListeningConn = false;
  bool isClosing = false;
  StreamSubscription<BluetoothConnectionState>? connectionListener;
  StreamSubscription<List<int>>? charListener;

  int battery = -1;

  DateTime? lastScan;
  BluetoothDevice? device;
  BluetoothCharacteristic? characteristic; //用于write/read
  BluetoothCharacteristic? notifyCharacteristic; //用于notify/read
  Map<String /* service_uuid + chara_uuid */, BluetoothCharacteristic>
      allCharacteristic = {};

  int rssi = -1000;
  ProductConfig? productConfig;
  String _deviceId = '';
  String _deviceName = '';
  String _localName = '';
  int connectTimestamp = 0; // 单位：秒

  BleDevice(this.device) {
    listenBleState();
  }
  BleDevice.fromId(String adeviceId, String adeviceName)
      : _deviceId = adeviceId,
        _deviceName = adeviceName {
    device = null;
    listenBleState();
  }

  BleDeviceState getBleState() {
    if (bleState.value == BluetoothConnectionState.disconnected) {
      return BleDeviceState.disconnected;
    } else if (bleState.value == BluetoothConnectionState.connected) {
      return BleDeviceState.connected;
    }

    return BleDeviceState.none;
  }

  void reset() {
    characteristic = null;
    notifyCharacteristic = null;
  }

  String get localName {
    if (Platform.isIOS && _localName.isNotEmpty) {
      return _localName;
    } else {
      return deviceName;
    }
  }

  set localName(String value) {
    _localName = value;
  }

  String get deviceId {
    if (device == null) {
      return _deviceId;
    }
    return device!.remoteId.toString();
  }

  String get deviceName {
    if (device == null) return _deviceName;

    return device!.platformName;
  }

  set deviceName(var newName) {
    _deviceName = newName;
  }

  String deviceRawName() {
    return _deviceName;
  }

  void setDeviceRawName(String newName) {
    _deviceName = newName;
    WorkingDevice workingDevice = Get.find();
    workingDevice.updateUI();
  }

  listenBleState() {
    ever(bleState, (_) {
      WorkingDevice workingDevice = Get.find();
      workingDevice.updateUI();
    });
  }
}
