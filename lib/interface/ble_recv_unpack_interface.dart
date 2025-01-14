import 'dart:typed_data';

import '../blelib.dart';

// 公用协议数据解包接口
abstract class BleCommonRecvUnpackInterface {
  void onRecvGetDeviceName(BleDevice bleDevice, Uint8List content);
  /*
  void onRecvStartSession(BleDevice bleDevice, Uint8List content);
  void onRecvReadStatus(BleDevice bleDevice, Uint8List content);
  void onRecvSetDeviceName(BleDevice bleDevice, Uint8List content);
  void onRecvSetDevicePin(BleDevice bleDevice, Uint8List content);
  void onRecvKeyAuth(BleDevice bleDevice, Uint8List content);
  void onRecvReverseKeyAuth(BleDevice bleDevice, Uint8List content);
  void onRecvGetVersion(BleDevice bleDevice, Uint8List content);
  void onRecvSyncTime(BleDevice bleDevice, Uint8List content);
  void onRecvReadDeviceCode(BleDevice bleDevice, Uint8List content);
  void onRecvSetModeParam(BleDevice bleDevice, Uint8List content);
  void onRecvSetStrengthParam(BleDevice bleDevice, Uint8List content);
  void onRecvSetTimeLenParams(BleDevice bleDevice, Uint8List content);
  void onRecvNotifyModeParam(BleDevice bleDevice, Uint8List content);
  void onRecvNotifyStrengthParam(BleDevice bleDevice, Uint8List content);
  void onRecvReadModeParam(BleDevice bleDevice, Uint8List content);
  void onRecvReadStrengthParam(BleDevice bleDevice, Uint8List content);
  void onRecvSetStart(BleDevice bleDevice, Uint8List content);
  void onRecvSetStop(BleDevice bleDevice, Uint8List content);
  void onRecvNotifyStart(BleDevice bleDevice, Uint8List content);
  void onRecvNotifyStop(BleDevice bleDevice, Uint8List content);
  void onRecvSetDefaultMode(BleDevice bleDevice, Uint8List content);
  void onRecvReadDefaultModeParam(BleDevice bleDevice, Uint8List content);
  void onRecvShutdown(BleDevice bleDevice, Uint8List content);
  void onRecvNotifyShutdown(BleDevice bleDevice, Uint8List content);
  void onRecvSetDeviceCode(BleDevice bleDevice, Uint8List content);
  */
}
