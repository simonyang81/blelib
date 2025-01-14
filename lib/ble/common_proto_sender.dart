part of blelib;

// import 'package:blelib/ble/common_proto_packer.dart';
// import 'package:blelib/ble/define.dart';
// import 'package:blelib/ble/log.dart';
// import 'package:blelib/blelib.dart';
// import 'package:blelib/interface/ble_send_interface.dart';

class CommonProtoSender implements BleCommonSendInterface {
  CommonProtoContentPacker commonProtoPacker = CommonProtoContentPacker();
  factory CommonProtoSender() => _getInstance();
  static CommonProtoSender get instance => _getInstance();
  static CommonProtoSender? _instance;
  static CommonProtoSender _getInstance() {
    _instance ??= CommonProtoSender._internal();
    return _instance!;
  }

  CommonProtoSender._internal() {
    ekLog('CommonProtoSender._internal');
  }

  @override
  bool sendGetDeviceName(BleDevice device) {
    var packContent = commonProtoPacker.packGetDeviceName();
    sendMessage(device, CmdOrder.CMD_GET_DEVICE_NAME, packContent);
    return true;
  }

  @override
  bool sendGetVersion(BleDevice device) {
    var packContent = commonProtoPacker.packGetVersion();
    sendMessage(device, CmdOrder.CMD_GET_FW_VERSION, packContent);
    return true;
  }

  @override
  bool sendNotifyMode(BleDevice device, int result) {
    var packContent = commonProtoPacker.packNotifyMode(result);
    sendMessage(device, CmdOrder.CMD_NOTIFY_MODE_CONFIRM, packContent);
    return true;
  }

  @override
  bool sendNotifyShutdown(BleDevice device, int result) {
    var packContent = commonProtoPacker.packNotifyShutdown(result);
    sendMessage(device, CmdOrder.CMD_NOTIFY_SHUTDOWN_CONFIRM, packContent);
    return true;
  }

  @override
  bool sendNotifyStart(BleDevice device, int result) {
    var packContent = commonProtoPacker.packNotifyStart(result);
    sendMessage(device, CmdOrder.CMD_NOTIFY_START_CONFIRM, packContent);
    return true;
  }

  @override
  bool sendNotifyStop(BleDevice device, int result) {
    var packContent = commonProtoPacker.packNotifyStop(result);
    sendMessage(device, CmdOrder.CMD_NOTIFY_STOP_CONFIRM, packContent);
    return true;
  }

  @override
  bool sendNotifyLevel(BleDevice device, int result) {
    var packContent = commonProtoPacker.packNotifyLevel(result);
    sendMessage(device, CmdOrder.CMD_NOTIFY_LEVEL_CONFIRM, packContent);
    return true;
  }

  @override
  bool sendReadDefaultMode(BleDevice device) {
    var packContent = commonProtoPacker.packReadDefaultMode();
    sendMessage(device, CmdOrder.CMD_GET_DEFAULT_MODE, packContent);
    return true;
  }

  @override
  bool sendReadEikCode(BleDevice device) {
    var packContent = commonProtoPacker.packReadEikCode();
    sendMessage(device, CmdOrder.CMD_GET_EIK_CODE, packContent);
    return true;
  }

  @override
  bool sendReadMode(BleDevice device) {
    var packContent = commonProtoPacker.packReadMode();
    sendMessage(device, CmdOrder.CMD_GET_MODE, packContent);
    return true;
  }

  @override
  bool sendReadStatus(BleDevice device) {
    var packContent = commonProtoPacker.packReadStatus();
    sendMessage(device, CmdOrder.CMD_GET_DEV_STATUS, packContent);
    return true;
  }

  @override
  bool sendReadLevel(BleDevice device) {
    var packContent = commonProtoPacker.packReadStrength();
    sendMessage(device, CmdOrder.CMD_GET_LEVEL, packContent);
    return true;
  }

  @override
  bool sendSetDefaultMode(BleDevice device, int mode) {
    var packContent = commonProtoPacker.packSetDefaultMode(mode);
    sendMessage(device, CmdOrder.CMD_SET_DEFAULT_MODE, packContent);
    return true;
  }

  @override
  bool sendSetDeviceName(BleDevice device, String deviceName) {
    var packContent = commonProtoPacker.packSetDeviceName(deviceName);
    sendMessage(device, CmdOrder.CMD_SET_DEVICE_NAME, packContent);
    return true;
  }

  @override
  bool sendSetMode(BleDevice device, int mode) {
    var packContent = commonProtoPacker.packSetMode(mode);
    sendMessage(device, CmdOrder.CMD_SET_MODE, packContent);
    return true;
  }

  @override
  bool sendSetStart(BleDevice device) {
    var packContent = commonProtoPacker.packSetStart();
    sendMessage(device, CmdOrder.CMD_START, packContent);
    return true;
  }

  @override
  bool sendSetStop(BleDevice device) {
    var packContent = commonProtoPacker.packSetStop();
    sendMessage(device, CmdOrder.CMD_STOP, packContent);
    return true;
  }

  @override
  bool sendSetLevel(BleDevice device, int strength) {
    var packContent = commonProtoPacker.packSetLevel(strength);
    sendMessage(device, CmdOrder.CMD_SET_LEVEL, packContent);
    return true;
  }

  @override
  bool sendSetTimeLen(BleDevice device, int timeLen) {
    var packContent = commonProtoPacker.packSetTimeLen(timeLen);
    sendMessage(device, CmdOrder.CMD_SET_TIME_LEN, packContent);
    return true;
  }

  @override
  bool sendShutdown(BleDevice device) {
    var packContent = commonProtoPacker.packShutdown();
    sendMessage(device, CmdOrder.CMD_SHUTDOWN, packContent);
    return true;
  }

  @override
  bool sendSyncTime(BleDevice device, int year, int month, int day, int hour,
      int minute, int second) {
    var packContent =
        commonProtoPacker.packSyncTime(year, month, day, hour, minute, second);
    sendMessage(device, CmdOrder.CMD_SYNC_TIME, packContent);
    return true;
  }

  @override
  bool sendNotifyBattery(BleDevice device, int result) {
    var packContent = commonProtoPacker.packNotifyBattery(result);
    sendMessage(device, CmdOrder.CMD_NOTIFY_BATTERY_LEVEL_CONFIRM, packContent);
    return true;
  }

  @override
  bool sendSetPause(BleDevice device) {
    var packContent = commonProtoPacker.packSetPause();
    sendMessage(device, CmdOrder.CMD_PAUSE, packContent);
    return true;
  }

  @override
  bool sendNotifyPause(BleDevice device, int result) {
    var packContent = commonProtoPacker.packNotifyPause(result);
    sendMessage(device, CmdOrder.CMD_NOTIFY_PAUSE_CONFIRM, packContent);
    return true;
  }

  @override
  bool sendReadTimeLen(BleDevice device) {
    var packContent = commonProtoPacker.packReadTimeLen();
    sendMessage(device, CmdOrder.CMD_GET_TIME_LEN, packContent);
    return true;
  }

  @override
  bool sendNotifyTimeLen(BleDevice device, int result) {
    var packContent = commonProtoPacker.packNotifyTimeLen(result);
    sendMessage(device, CmdOrder.CMD_NOTIFY_TIME_LEN_CONFIRM, packContent);
    return true;
  }

  @override
  bool sendReadBattery(BleDevice device) {
    var packContent = commonProtoPacker.packReadBattery();
    sendMessage(device, CmdOrder.CMD_GET_BATTERY_LEVEL, packContent);
    return true;
  }

  @override
  bool sendReadDefaultLevel(BleDevice device) {
    var packContent = commonProtoPacker.packReadDefaultLevel();
    sendMessage(device, CmdOrder.CMD_GET_DEFAULT_LEVEL, packContent);
    return true;
  }

  @override
  bool sendReadTestFlag(BleDevice device) {
    var packContent = commonProtoPacker.packReadTestFlag();
    sendMessage(device, CmdOrder.CMD_GET_TEST_FLAG, packContent);
    return true;
  }

  @override
  bool sendSetDefaultLevel(BleDevice device, int level) {
    var packContent = commonProtoPacker.packSetDefaultLevel(level);
    sendMessage(device, CmdOrder.CMD_SET_DEFAULT_LEVEL, packContent);
    return true;
  }

  @override
  bool sendSetTestFlag(BleDevice device, int flag) {
    var packContent = commonProtoPacker.packSetTestFlag(flag);
    sendMessage(device, CmdOrder.CMD_SET_TEST_FLAG, packContent);
    return true;
  }

  @override
  bool sendBigDataTest(BleDevice device, Uint8List data) {
    var packContent = commonProtoPacker.packSendBigDataTest(data);
    sendMessage(device, CmdOrder.CMD_BIG_DATA_TEST_RECV, packContent);
    return true;
  }

  @override
  bool sendReadPropertyCode(BleDevice device) {
    var packContent = commonProtoPacker.packReadPropertyCode();
    sendMessage(device, CmdOrder.CMD_GET_PROPERTY_CODE, packContent);
    return true;
  }

  @override
  bool sendSetEikCodeTest(BleDevice device, Uint8List data) {
    var packContent = commonProtoPacker.packSendBigDataTest(data);
    sendMessage(device, CmdOrder.CMD_SET_EIKER_CODE_TEST, packContent);
    return true;
  }

  @override
  bool sendSetPropertyCodeTest(BleDevice device, Uint8List data) {
    var packContent = commonProtoPacker.packSendBigDataTest(data);
    sendMessage(device, CmdOrder.CMD_SET_PROPERTY_CODE_TEST, packContent);
    return true;
  }

  /*

  @override
  bool sendGetVersion(BleDevice device) {
    var packContent = commonProtoPacker.packGetVersion();
    sendMessage(device, CmdOrder.getVersion, packContent);

    return true;
  }

  @override
  bool sendKeyAuth(BleDevice device) {
   
    return false;
  }

  @override
  bool sendNotifyModeParam(BleDevice device, int result) {
    var packContent = commonProtoPacker.packNotifyModeParam(result);
    sendMessage(device, CmdOrder.notifyModeParam, packContent);
    return true;
  }

  @override
  bool sendNotifyShutdown(BleDevice device, int result) {
    var packContent = commonProtoPacker.packNotifyShutdown(result);
    sendMessage(device, CmdOrder.notifyShutdown, packContent);
    return true;
  }

  @override
  bool sendNotifyStart(BleDevice device, int result) {
    var packContent = commonProtoPacker.packNotifyStart(result);
    sendMessage(device, CmdOrder.notifyStart, packContent);
    return true;
  }

  @override
  bool sendNotifyStop(BleDevice device, int result) {
    var packContent = commonProtoPacker.packNotifyStop(result);
    sendMessage(device, CmdOrder.notifyStop, packContent);
    return true;
  }

  @override
  bool sendNotifyStrengthParam(BleDevice device, int result) {
    var packContent = commonProtoPacker.packNotifyStrengthParam(result);
    sendMessage(device, CmdOrder.notifyStrengthParam, packContent);
    throw UnimplementedError();
  }

  @override
  bool sendReadDefaultModeParam(BleDevice device) {
    var packContent = commonProtoPacker.packReadDefaultModeParam();
    sendMessage(device, CmdOrder.readDefaultModeParam, packContent);
    return true;
  }

  @override
  bool sendReadDeviceCode(BleDevice device) {
    var packContent = commonProtoPacker.packReadDeviceCode();
    sendMessage(device, CmdOrder.readDeviceCode, packContent);
    return true;
  }

  @override
  bool sendReadModeParam(BleDevice device) {
    var packContent = commonProtoPacker.packReadModeParam();
    sendMessage(device, CmdOrder.readModeParam, packContent);
    return true;
  }

  @override
  bool sendReadStatus(BleDevice device) {
    var packContent = commonProtoPacker.packReadStatus();
    sendMessage(device, CmdOrder.readStatus, packContent);
    return true;
  }

  @override
  bool sendReadStrengthParam(BleDevice device) {
    var packContent = commonProtoPacker.packReadStrengthParam();
    sendMessage(device, CmdOrder.readStrengthParam, packContent);
    return true;
  }

  @override
  bool sendReverseKeyAuth(BleDevice device) {
    return false;
  }

  @override
  bool sendSetDefaultMode(
      BleDevice device, int mode, int strength, int timeLen) {
    var packContent =
        commonProtoPacker.packSetDefaultMode(mode, strength, timeLen);
    sendMessage(device, CmdOrder.setDefaultModeParam, packContent);
    return true;
  }

  @override
  bool sendSetDeviceCode(BleDevice device, int codeVersion, int length,
      int uniqueCode, int deviceCode) {
    var packContent = commonProtoPacker.packSetDeviceCode(
        codeVersion, length, uniqueCode, deviceCode);
    sendMessage(device, CmdOrder.setDeviceCode, packContent);
    return true;
  }

  @override
  bool sendSetDeviceName(BleDevice device, String deviceName) {
    var packContent = commonProtoPacker.packSetDeviceName(deviceName);
    sendMessage(device, CmdOrder.setDeviceName, packContent);
    return true;
  }

  @override
  bool sendSetDevicePin(BleDevice device, String devicePin) {
    var packContent = commonProtoPacker.packSetDevicePin(devicePin);
    sendMessage(device, CmdOrder.setDevicePin, packContent);
    return true;
  }

  @override
  bool sendSetModeParam(BleDevice device, int mode) {
    var packContent = commonProtoPacker.packSetModeParam(mode);
    sendMessage(device, CmdOrder.setModeParam, packContent);
    return true;
  }

  @override
  bool sendSetStart(BleDevice device) {
    var packContent = commonProtoPacker.packSetStart();
    sendMessage(device, CmdOrder.setStart, packContent);
    return true;
  }

  @override
  bool sendSetStop(BleDevice device) {
    var packContent = commonProtoPacker.packSetStop();
    sendMessage(device, CmdOrder.setStop, packContent);
    return true;
  }

  @override
  bool sendSetStrengthParam(BleDevice device, int strength) {
    var packContent = commonProtoPacker.packSetStrengthParam(strength);
    sendMessage(device, CmdOrder.setStrengthParam, packContent);
    return true;
  }

  @override
  bool sendSetTimeLenParams(BleDevice device, int timeLen) {
    var packContent = commonProtoPacker.packSetTimeLenParams(timeLen);
    sendMessage(device, CmdOrder.setTimeLenParams, packContent);
    return true;
  }

  @override
  bool sendShutdown(BleDevice device) {
    var packContent = commonProtoPacker.packShutdown();
    sendMessage(device, CmdOrder.shutdown, packContent);
    return true;
  }

  @override
  bool sendStartSession(BleDevice device) {
    math.Random rand = math.Random();
    int randNum = rand.nextInt(1 << 32);
    var packContent = commonProtoPacker.packStartSession(randNum);
    device.sessionKey = packContent;
    sendMessage(device, CmdOrder.startSession, null);

    return true;
  }

  @override
  bool sendSyncTime(BleDevice device, int year, int month, int day, int hour,
      int minute, int second) {
    var packContent =
        commonProtoPacker.packSyncTime(year, month, day, hour, minute, second);
    sendMessage(device, CmdOrder.syncTime, packContent);
    return true;
  }
  */
}
