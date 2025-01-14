import 'dart:typed_data';

import 'package:blelib/blelib.dart';

// 公用数据接收回调接口
abstract class BleCommonRecvInterface {
  void onRecvGetDeviceName(
      BleDevice bleDevice, bool result, Uint8List deviceName);
  void onRecvSetDeviceName(BleDevice bleDevice, bool result);
  void onRecvGetEIKCode(BleDevice bleDevice, bool result, Uint8List eikCode);
  void onRecvGetFWVersion(BleDevice bleDevice, bool result, Uint8List version);
  void onRecvSyncTime(BleDevice bleDevice, bool result);
  void onRecvSetTestFlag(BleDevice bleDevice, bool result);
  void onRecvGetTestFlag(BleDevice bleDevice, bool result, Uint8List testFlag);
  void onRecvGetDevStatus(
      BleDevice bleDevice, bool result, Uint8List devStatus);
  void onRecvStart(BleDevice bleDevice, bool result);
  void onRecvNotifyStart(BleDevice bleDevice);
  void onRecvPause(BleDevice bleDevice, bool result);
  void onRecvNotifyPause(BleDevice bleDevice);
  void onRecvStop(BleDevice bleDevice, bool result);
  void onRecvNotifyStop(BleDevice bleDevice);
  void onRecvShutdown(BleDevice bleDevice, bool result);
  void onRecvNotifyShutdown(BleDevice bleDevice);
  void onRecvSetMode(BleDevice bleDevice, bool result, Uint8List mode);
  void onRecvGetMode(BleDevice bleDevice, bool result, Uint8List mode);
  void onRecvNotifyMode(BleDevice bleDevice, Uint8List mode);
  void onRecvSetDefaultMode(BleDevice bleDevice, bool result);
  void onRecvGetDefaultMode(
      BleDevice bleDevice, bool result, Uint8List defaultMode);
  void onRecvSetLevel(BleDevice bleDevice, bool result, Uint8List level);
  void onRecvGetLevel(BleDevice bleDevice, bool result, Uint8List level);
  void onRecvNotifyLevel(BleDevice bleDevice, Uint8List level);
  void onRecvSetDefaultLevel(BleDevice bleDevice, bool result);
  void onRecvGetDefaultLevel(
      BleDevice bleDevice, bool result, Uint8List defaultLevel);
  void onRecvSetTimeLen(BleDevice bleDevice, bool result, Uint8List timer);
  void onRecvGetTimeLen(BleDevice bleDevice, bool result, Uint8List timer);
  void onRecvNotifyTimeLen(BleDevice bleDevice, Uint8List timer);
  void onRecvGetBatteryLevel(
      BleDevice bleDevice, bool result, Uint8List batteryLevel);
  void onRecvNotifyBatteryLevel(
      BleDevice bleDevice, Uint8List batteryLevel);
  void onRecvBigData(BleDevice device, bool result, Uint8List data);
  void onRecvPropertyCode(BleDevice device, bool result, Uint8List propertyCode);
  /*
  void onRecvStartSession(BleDevice bleDevice, Uint8List content);
  void onRecvReadStatus(BleDevice bleDevice, Uint8List content);
  void onRecvSetDeviceName(BleDevice bleDevice, bool result);
  void onRecvSetDevicePin(BleDevice bleDevice, bool result);
  void onRecvKeyAuth(BleDevice bleDevice, Uint8List content);
  void onRecvReverseKeyAuth(BleDevice bleDevice, Uint8List content);
  void onRecvGetVersion(BleDevice bleDevice, String version);
  void onRecvSyncTime(BleDevice bleDevice, bool result);
  void onRecvReadDeviceCode(BleDevice bleDevice, Uint8List content);
  void onRecvSetModeParam(BleDevice bleDevice, bool result);
  void onRecvSetStrengthParam(BleDevice bleDevice, bool result);
  void onRecvSetTimeLenParams(BleDevice bleDevice, bool result);
  void onRecvNotifyModeParam(BleDevice bleDevice, int mode);
  void onRecvNotifyStrengthParam(BleDevice bleDevice, int strength);
  void onRecvReadModeParam(BleDevice bleDevice, int mode);
  void onRecvReadStrengthParam(BleDevice bleDevice, int strength);
  void onRecvSetStart(BleDevice bleDevice, bool result);
  void onRecvSetStop(BleDevice bleDevice, bool result);
  void onRecvNotifyStart(BleDevice bleDevice);
  void onRecvNotifyStop(BleDevice bleDevice);
  void onRecvSetDefaultMode(BleDevice bleDevice, bool result);
  void onRecvReadDefaultModeParam(BleDevice bleDevice, Uint8List content);
  void onRecvShutdown(BleDevice bleDevice, bool result);
  void onRecvNotifyShutdown(BleDevice bleDevice, int timeLeft);
  void onRecvSetDeviceCode(BleDevice bleDevice, bool result);
  */
}
