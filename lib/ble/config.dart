part of blelib;

class Config {
  // static late List<String> gAesKeyList; // AES加解密的key
  // static late List<String> gBleDevicePrefixList; // 排列顺序必须与gAesKeyList一致
  // static late List<String> gBleServiceUuidList;
  // static late List<String> gBleCharacteristicUuidList;
  // static late List<String> gBleNotifyCharacteristicUuidList;
  static Map<String /* service uuid */, List<String> /* chara uuid*/ >
      gBleServiceUuidMap = {};
  static int gMtu = 20;
  static bool gUseAesEncrypt = false;
  static bool gUseChecksum = false; // 数据包格式中是否有checksum
  static int gHistoryCount = 10; // 存储手机上历史记录设备数量
  static int gSendMessageDelayMs = 200;
  static bool gPrintLog = false;
  static bool gAutoReconnect = true;
  static bool gAutoRescan = true;
  static bool gAutoRescanForce = false;
  static bool gShouldClearGattCache = false;
  static String gReconnectDeviceId = ''; // 当为空时，去getLostDevice, 否则重连指定id
  static String gReconnectDeviceName = '';
  static int gDisconnectWaitSeconds = 1;
  static bool gOnlyReconnectLast = false;
  //static int gBleConfigIndex = 0;
  static bool autoSortByRSSI = false; // 按rssi信号强弱排序
  static bool isUnitTest = false;
  static const String defaultScanFilterUuid =
      '0000af30-0000-1000-8000-00805f9b34fb';
  static bool needAppendAdvUuid = true;

  //=================scan with service===============

  static List<ProductConfig> configList = [];

  static void addProductConfig(ProductConfig config) {
    configList.add(config);
  }

  static List<String> getAllServiceUuids() {
    List<String> allUuids = [];
    for (var config in configList) {
      if (config.serviceUuid.isNotEmpty) {
        allUuids.add(config.serviceUuid);
      }
    }

    return allUuids;
  }

  static List<String> getAllCharacteristicUuids() {
    List<String> allUuids = [];
    for (var config in configList) {
      if (config.writeCharacterUuid.isNotEmpty) {
        allUuids.add(config.writeCharacterUuid);
      }
      if (config.notifyCharacterUuid.isNotEmpty) {
        allUuids.add(config.notifyCharacterUuid);
      }
    }

    return allUuids;
  }

  static List<String> getAllScanFilterUuids() {
    List<String> allUuids = [];
    for (var config in configList) {
      if (config.scanUuid != null && config.scanUuid!.isNotEmpty) {
        allUuids.add(config.scanUuid!);
      }
    }
    allUuids.add(defaultScanFilterUuid);
    return allUuids;
  }

  static List<String> getAllPrefix() {
    List<String> allPrefix = [];
    for (var config in configList) {
      if (config.prefix != null && config.prefix!.isNotEmpty) {
        allPrefix.add(config.prefix!);
      }
    }
    return allPrefix;
  }

  static void enableLog(bool enable) {
    gPrintLog = enable;
  }

  static void enableAutoReconnect(bool enable) {
    gAutoReconnect = enable;
  }

  static void enableAutoRescan(bool enable) {
    gAutoRescan = enable;
  }

  static void setMtu(int mtu) {
    gMtu = mtu;
  }
}
