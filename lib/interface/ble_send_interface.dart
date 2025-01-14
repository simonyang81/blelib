import 'dart:typed_data';

import 'package:blelib/blelib.dart';

// 公用协议数据发送接口
abstract class BleCommonSendInterface {
  bool sendGetDeviceName(BleDevice device);
  bool sendSetDeviceName(BleDevice device, String deviceName);
  bool sendReadEikCode(BleDevice device);
  bool sendGetVersion(BleDevice device);
  bool sendSyncTime(BleDevice device, int year, int month, int day, int hour, int minute, int second);
  bool sendSetTestFlag(BleDevice device, int flag);
  bool sendReadTestFlag(BleDevice device);
  bool sendReadStatus(BleDevice device);
  bool sendSetStart(BleDevice device);
  bool sendNotifyStart(BleDevice device, int result);
  bool sendSetPause(BleDevice device);
  bool sendNotifyPause(BleDevice device, int result);
  bool sendSetStop(BleDevice device);
  bool sendNotifyStop(BleDevice device, int result);
  bool sendShutdown(BleDevice device);
  bool sendNotifyShutdown(BleDevice device, int result);
  bool sendSetMode(BleDevice device, int mode);
  bool sendReadMode(BleDevice device);
  bool sendNotifyMode(BleDevice device, int result);
  bool sendSetDefaultMode(BleDevice device, int mode);
  bool sendReadDefaultMode(BleDevice device);
  bool sendSetLevel(BleDevice device, int strength);
  bool sendReadLevel(BleDevice device);
  bool sendNotifyLevel(BleDevice device, int result);
  bool sendSetDefaultLevel(BleDevice device, int level);
  bool sendReadDefaultLevel(BleDevice device);
  bool sendSetTimeLen(BleDevice device, int timeLen);
  bool sendReadTimeLen(BleDevice device);
  bool sendNotifyTimeLen(BleDevice device, int result);
  bool sendReadBattery(BleDevice device);
  bool sendNotifyBattery(BleDevice device, int result);
  bool sendBigDataTest(BleDevice device, Uint8List data);
  bool sendReadPropertyCode(BleDevice device);
  bool sendSetPropertyCodeTest(BleDevice device, Uint8List data);
  bool sendSetEikCodeTest(BleDevice device, Uint8List data);
}
