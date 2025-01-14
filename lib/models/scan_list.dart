part of blelib;

class ScanModel extends GetxController {
  RxList<BleDevice> scanList = <BleDevice>[].obs;

  void sortByRSSI() {
    for (var i = 0; i < scanList.length - 1; i++) {
      for (var j = 0; j < scanList.length - 1 - i; j++) {
        if (scanList[j].rssi < scanList[j + 1].rssi) {
          var temp = scanList[j];
          scanList[j] = scanList[j + 1];
          scanList[j + 1] = temp;
        }
      }
    }
  }

  String printScanListName() {
    String scanListName = '';
    for (var scanResult in scanList) {
      scanListName += scanResult.device!.platformName;
    }
    return scanListName;
  }

  int count() {
    return scanList.length;
  }

  BleDevice? first() {
    if (scanList.isEmpty) return null;
    return scanList.first;
  }

  BleDevice? getAt(int index) {
    if (scanList.isEmpty || index >= scanList.length) return null;
    return scanList[index];
  }

  bool containId(DeviceIdentifier id) {
    if (scanList.any((element) {
      return element.device!.remoteId == id;
    })) {
      return true;
    }
    return false;
  }

  BleDevice? getById(DeviceIdentifier id) {
    for (var item in scanList) {
      if (item.device == null) continue;
      if (item.device!.remoteId == id) {
        return item;
      }
    }

    return null;
  }

  BleDevice? getByIdString(String id) {
    for (var item in scanList) {
      if (item.device == null) continue;
      if (item.device!.remoteId.toString().toLowerCase() == id.toLowerCase()) {
        return item;
      }
    }

    return null;
  }

  void add(BleDevice device) {
    DeviceIdentifier deviceId = (device.device == null
        ? DeviceIdentifier(device.deviceId)
        : device.device!.remoteId);
    if (scanList.any((element) => element.device!.remoteId == deviceId)) {
      ekLog('ble-scan:already in scan list............');
      return;
    }
    WorkingDevice bindedList = Get.find();
    var curDevice = bindedList.getById(deviceId);

    if (curDevice == null) {
      ekLog('ble-scan:added in to scan list.............');
      scanList.add(device);
    }
  }

  void clear() {
    scanList.clear();
  }

  void remove(BleDevice device) {
    ekLog('remove from scan list....');
    scanList.remove(device);
  }

  void remoteAt(int i) {
    scanList.removeAt(i);
  }
}
