import 'dart:typed_data';

// 公用协议数据打包接口
abstract class BleCommonSendPackInterface {
  Uint8List? packGetDeviceName();
  Uint8List? packStartSession(int randNum);
  Uint8List? packReadStatus();
  Uint8List? packSetDeviceName(String deviceName);
  Uint8List? packSetDevicePin(String devicePin);
  Uint8List? packKeyAuth(Uint8List keyAuth);
  Uint8List? packReverseKeyAuth(Uint8List reverseKeyAuth);
  Uint8List? packGetVersion();
  Uint8List? packSyncTime(int year, int month, int day, int hour, int minute, int second);
  Uint8List? packReadEikCode();
  Uint8List? packSetMode(int mode);
  Uint8List? packSetLevel(int strength);
  Uint8List? packSetTimeLen(int timeLen);
  Uint8List? packNotifyMode(int result);
  Uint8List? packNotifyLevel(int result);
  Uint8List? packReadMode();
  Uint8List? packReadStrength();
  Uint8List? packSetStart();
  Uint8List? packSetStop();
  Uint8List? packNotifyStart(int result);
  Uint8List? packNotifyStop(int result);
  Uint8List? packSetDefaultMode(int mode);
  Uint8List? packReadDefaultMode();
  Uint8List? packShutdown();
  Uint8List? packNotifyShutdown(int result);
  Uint8List? packNotifyBattery(int result);
  Uint8List? packSetPause();
  Uint8List? packNotifyPause(int result);
  Uint8List? packNotifyTimeLen(int result);
  Uint8List? packReadTimeLen();
  Uint8List? packReadBattery();
  Uint8List? packSetDefaultLevel(int level);
  Uint8List? packReadDefaultLevel();
  Uint8List? packSetTestFlag(int flag);
  Uint8List? packReadTestFlag();
  Uint8List? packSendBigDataTest(Uint8List data);
  Uint8List? packReadPropertyCode();
}
