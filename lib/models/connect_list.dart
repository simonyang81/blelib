part of blelib;

class WorkingDevice extends GetxController {
  RxList<BleDevice> bindDevices = <BleDevice>[].obs;

  RxString testState = ''.obs;
  late BleLocalDB db;
  //BleDevice? currentDevice;

  @override
  Future<void> onInit() async {
    super.onInit();

    db = await BleLocalDB.create();

    List<BleDevice> bindDeviceList = await loadBindDeviceFromLocal();
    ekLog('onInit().....');
    bindDevices.value = bindDeviceList;
  }

  Future<List<BleDevice>> loadBindDeviceFromLocal() async {
    List<BleDevice> bindList = [];
    List<Map> res = await db.getLocalBindDeviceList();
    try {
      for (int i = 0; i < res.length; i++) {
        var device = BleDevice.fromId(res[i]['mac_id'], res[i]['name']);
        device.connectTimestamp = res[i]['connect_time'];
        bindList.add(device);
      }
      return bindList;
    } catch (e) {
      ekLog('loadBindDeviceFromLocal$e');
      return [];
    }
  }

  BleDevice? getLastUsingDevice() {
    int index = -1;
    int maxTimestamp = 0;
    for (int i = 0; i < bindDevices.length; i++) {
      if (bindDevices[i].connectTimestamp > maxTimestamp) {
        index = i;
        maxTimestamp = bindDevices[i].connectTimestamp;
      }
    }

    if (index == -1) return null;

    return bindDevices[index];
  }

  BleDevice? getAvailableBindDevice() {
    for (int i = 0; i < bindDevices.length; i++) {
      if (bindDevices[i].device != null &&
          bindDevices[i].isScanAvailable.value) {
        return bindDevices[i];
      }
    }

    return null;
  }

  BleDevice? getBleConnectDevice() {
    for (int i = bindDevices.length - 1; i >= 0; i--) {
      if (bindDevices[i].device != null &&
          bindDevices[i].bleState.value == BluetoothConnectionState.connected) {
        return bindDevices[i];
      }
    }

    return null;
  }

  BleDevice? getConnectedDevice() {
    for (int i = bindDevices.length - 1; i >= 0; i--) {
      if (bindDevices[i].device != null &&
          bindDevices[i].bleState.value == BluetoothConnectionState.connected) {
        return bindDevices[i];
      }
    }

    return null;
  }

  BleDevice? getLostDevice() {
    if (bindDevices.isEmpty) return null;

    var connectedDevice = getBleConnectDevice();
    if (connectedDevice != null) {
      ekLog("ble: getLostDevice connectedDevice != null");
      return null;
    }

    var scanAvailableDevice = getAvailableBindDevice();
    if (scanAvailableDevice != null &&
        scanAvailableDevice.bleState.value ==
            BluetoothConnectionState.disconnected) {
      ekLog("ble: getLostDevice connectedDevice != null");
      return scanAvailableDevice;
    }

    return null;
  }

  BleDevice? first() {
    if (bindDevices.isEmpty) return null;
    return bindDevices.first;
  }

  void updateUI() {
    update(['connect-status']);
  }

  int count() {
    return bindDevices.length;
  }

  bool isEmpty() {
    return bindDevices.isEmpty;
  }

  BleDevice? getAt(int index) {
    if (bindDevices.isEmpty || index >= bindDevices.length) return null;
    return bindDevices[index];
  }

  BleDevice? getById(DeviceIdentifier id) {
    for (var item in bindDevices) {
      if ((item.device != null) && item.device!.remoteId == id) {
        return item;
      }
      if (DeviceIdentifier(item.deviceId) == id) {
        return item;
      }
    }

    return null;
  }

  BleDevice? getByIdString(String id) {
    for (var item in bindDevices) {
      if (item.device == null) continue;
      if (item.device!.remoteId.toString().toLowerCase() == id.toLowerCase()) {
        return item;
      }
    }

    return null;
  }

  void setRawDevice(BluetoothDevice device) {}

  BleDevice? getByBleRawDevice(BluetoothDevice device) {
    for (final item in bindDevices) {
      if (item.device != null && item.device!.remoteId == device.remoteId) {
        return item;
      }
    }

    return null;
  }

  void setTestStatus(String status) {
    testState.value = status;
  }

  void addOrUpdate(BleDevice device) {
    DeviceIdentifier deviceId = device.device == null
        ? DeviceIdentifier(device.deviceId)
        : device.device!.remoteId;

    for (var element in bindDevices) {
      if (element.device != null) {
        if (element.device!.remoteId == deviceId) {
          ekLog('remove..............1111');
          bindDevices.remove(element);
          break;
        }
      } else {
        if (DeviceIdentifier(element.deviceId) == deviceId) {
          ekLog('remove..............2222');
          bindDevices.remove(element);
          break;
        }
      }
    }

    ScanModel scan = Get.find();
    scan.remove(device);
    //bindDevices.add(device);
    bindDevices.insert(0, device);

    updateBindDevice(device);
  }

  void updateBindDevice(BleDevice device) {
    db.insertOrUpdateBindDevice(device);
    update(['connect-status']);
  }

  void keepTop(BleDevice device) {
    if (bindDevices.contains(device) == false || bindDevices.first == device) {
      return;
    }

    bindDevices.remove(device);
    bindDevices.insert(0, device);
  }

  void remove(BleDevice device) {
    ekLog('remove..............3333');
    bindDevices.remove(device);
    db.removeBindDevice(device.deviceId);

    update(['connect-status']);
  }

  void clear() {
    bindDevices.clear();

    db.clearLocalBindDevice();

    update(['connect-status']);
  }

  void remoteAt(int i) {
    ekLog('remove..............5555');
    if (i >= bindDevices.length) return;

    db.removeBindDevice(bindDevices[i].deviceId);
    bindDevices.removeAt(i);

    update(['connect-status']);
  }

  List<BleDevice> getDisconnectedDevices() {
    List<BleDevice> devices = [];
    for (var device in bindDevices) {
      if (device.bleState.value == BluetoothConnectionState.disconnected) {
        devices.add(device);
      }
    }

    return devices;
  }
}
