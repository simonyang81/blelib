part of blelib;

enum ConnectionState {
  disconnected,
  connected,
  channelReady,
}

typedef CharacteristicHandler = void Function(List<int>? datas);
typedef ConnectionStateChangeCallback = void Function(
    ConnectionState state, BleDevice device);

/* 业务数据回调接口，数据需要上面调用层自行解析
 ！！！此处回调content，其内容是不包含session key的
 cmd: 指令的命令编号
 content: 蓝牙协议中不包含session key的内容
*/
typedef DataReceiverCallback = void Function(
    BleDevice device, int cmd, Uint8List content);

class BleFunction {
  late BluetoothCharacteristic characteristic;
  late BluetoothDevice device;
}

class BleManager {
  factory BleManager() => _getInstance();
  static BleManager get instance => _getInstance();
  static BleManager? _instance;

  //List<BluetoothDevice> scanResultList = [];

  BleManager._internal() {
    ekLog('BleManager._internal');

    if (Config.isUnitTest) return;

    FlutterBluePlus.setLogLevel(LogLevel.debug);
    PhoneState().init();
  }
  static BleManager _getInstance() {
    _instance ??= BleManager._internal();
    return _instance!;
  }

  void start() {
    isWorking = true;
  }

  void stop() {
    isWorking = false;

    Config.gAutoReconnect = false;
    Config.gAutoRescan = false;
    Config.gAutoRescanForce = false;
  }

  Future<bool> isBleOn() async {
    var adapterState = await FlutterBluePlus.adapterState.first;
    return adapterState == BluetoothAdapterState.on;
  }

  bool isWorking = false;

  ScanModel scanModel = Get.put(ScanModel());
  WorkingDevice lockModel = Get.put<WorkingDevice>(WorkingDevice());
}
