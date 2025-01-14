// import 'dart:async';
// import 'dart:core';
// import 'dart:typed_data';

// import 'package:blelib/ble/common_proto_receiver.dart';
// import 'package:blelib/ble/data_receiver.dart';
// import 'package:blelib/ble/log.dart';
// import 'package:blelib/ble/product_config.dart';
// import 'package:blelib/blelib.dart';
// import 'package:blelib/interface/ble_recv_interface.dart';
// import 'package:flutter_blue_plus/flutter_blue_plus.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:get/get.dart';
// import 'package:mockito/annotations.dart';

// import 'receive_test.mocks.dart';

// @GenerateMocks([BluetoothDevice, FlutterBluePlus, BleManager])
// class CallbackTester implements BleCommonRecvInterface {
//   bool bSessionEvent = false;
//   bool onRecvGetDeviceName_result = false;
//   Uint8List? onRecvGetDeviceName_content;
//   bool onRecvSetDeviceName_result = false;
//   bool onRecvGetEIKCode_result = false;
//   Uint8List? onRecvGetEIKCode_content;
//   bool onRecvGetFWVerison_result = false;
//   Uint8List? onRecvGetFWVerison_content;
//   bool onRecvSyncTime_result = false;
//   bool onRecvSetTestFlag_result = false;
//   bool onRecvGetTestFlag_result = false;
//   bool onRecvGetDeviceStatus_result = false;
//   Uint8List? onRecvGetDeviceStatus_content;
//   bool onRecvSetStart_result = false;
//   bool onRecvNotifyStart_result = false;
//   bool onRecvPause_result = false;
//   bool onRecvSetStop_result = false;
//   bool onRecvShutdown_result = false;
//   bool onRecvSetMode_result = false;
//   Uint8List? onRecvSetMode_content;
//   bool onRecvGetMode_result = false;
//   Uint8List? onRecvGetMode_content;
//   Uint8List? onRecvNotifyMode_result;
//   bool onRecvSetDefaultMode_result = false;
//   bool onRecvGetDefaultMode_result = false;
//   Uint8List? onRecvGetDefaultMode_content;
//   bool onRecvSetLevel_result = false;
//   Uint8List? onRecvSetLevel_content;
//   bool onRecvGetLevel_result = false;
//   Uint8List? onRecvGetLevel_content;
//   Uint8List? onRecvNotifyLevel_result;
//   bool onRecvSetDefaultLevel_result = false;
//   bool onRecvGetDefaultLevel_result = false;
//   Uint8List? onRecvGetDefaultLevel_content;
//   bool onRecvSetTimeLen_result = false;
//   Uint8List? onRecvSetTimeLen_content;
//   bool onRecvGetTimeLen_result = false;
//   Uint8List? onRecvGetTimeLen_content;
//   Uint8List? onRecvNotifyTimeLen_result;
//   bool onRecvGetBatteryLevel_result = false;
//   Uint8List? onRecvGetBatteryLevel_content;
//   Uint8List? onRecvNotifyBatteryLevel_result;

//   String? onRecvGetVersion_version;
//   int? onRecvNotifyModeParam_mode;
//   int? onRecvNotifyShutdown_timeLeft;
//   // bool? onRecvNotifyStart_result;
//   // bool? onRecvNotifyStop_result;
//   int? onRecvNotifyStrengthParam_strength;
//   Uint8List? onRecvReadDefaultModeParam_List;
//   Uint8List? onRecvReadDeviceCode_List;
//   int? onRecvReadModeParam_mode;
//   Uint8List? onRecvReadStatus_List;
//   int? onRecvReadStrengthParam_strength;
//   // bool? onRecvSetDefaultMode_result;
//   bool? onRecvSetDeviceCode_result;
//   // bool? onRecvSetDeviceName_result;
//   bool? onRecvSetDevicePin_result;
//   bool? onRecvSetModeParam_result;
//   // bool? onRecvSetStart_result;
//   // bool? onRecvSetStop_result;
//   bool? onRecvSetStrengthParam_result;
//   bool? onRecvSetTimeLenParams_result;
//   // bool? onRecvShutdown_result;
//   Uint8List? onRecvStartSession_List;
//   // bool? onRecvSyncTime_result;
//   Uint8List? onRecvKeyAuth_List;

//   @override
//   void onRecvGetDeviceName(
//       BleDevice bleDevice, bool result, Uint8List deviceName) {
//     onRecvGetDeviceName_result = result;
//     onRecvGetDeviceName_content = deviceName;
//   }

//   @override
//   void onRecvSetDeviceName(BleDevice bleDevice, bool result) {
//     onRecvSetDeviceName_result = result;
//   }

//   @override
//   void onRecvGetEIKCode(BleDevice bleDevice, bool result, Uint8List eikCode) {
//     onRecvGetEIKCode_result = result;
//     onRecvGetEIKCode_content = eikCode;
//   }

//   @override
//   void onRecvGetFWVersion(BleDevice bleDevice, bool result, Uint8List version) {
//     onRecvGetFWVerison_result = result;
//     onRecvGetFWVerison_content = version;
//   }

//   @override
//   void onRecvSyncTime(BleDevice bleDevice, bool result) {
//     onRecvSyncTime_result = result;
//   }

//   @override
//   void onRecvSetTestFlag(BleDevice bleDevice, bool result) {
//     onRecvSetTestFlag_result = result;
//   }

//   @override
//   void onRecvGetTestFlag(BleDevice bleDevice, bool result, Uint8List testFlag) {
//     onRecvGetTestFlag_result = result;
//   }

//   @override
//   void onRecvGetDevStatus(
//       BleDevice bleDevice, bool result, Uint8List devStatus) {
//     onRecvGetDeviceStatus_result = result;
//     onRecvGetDeviceStatus_content = devStatus;
//   }

//   @override
//   void onRecvStart(BleDevice bleDevice, bool result) {
//     onRecvSetStart_result = result;
//   }

//   @override
//   void onRecvNotifyStart(BleDevice bleDevice) {}

//   @override
//   void onRecvPause(BleDevice bleDevice, bool result) {
//     onRecvPause_result = result;
//   }

//   @override
//   void onRecvNotifyPause(BleDevice bleDevice) {}

//   @override
//   void onRecvStop(BleDevice bleDevice, bool result) {
//     onRecvSetStop_result = result;
//   }

//   @override
//   void onRecvNotifyStop(BleDevice bleDevice) {}

//   @override
//   void onRecvShutdown(BleDevice bleDevice, bool result) {
//     onRecvShutdown_result = result;
//   }

//   @override
//   void onRecvNotifyShutdown(BleDevice bleDevice) {}

//   @override
//   void onRecvSetMode(BleDevice bleDevice, bool result, Uint8List mode) {
//     onRecvSetMode_result = result;
//     onRecvSetMode_content = mode;
//   }

//   @override
//   void onRecvGetMode(BleDevice bleDevice, bool result, Uint8List mode) {
//     onRecvGetMode_result = result;
//     onRecvGetMode_content = mode;
//   }

//   @override
//   void onRecvNotifyMode(BleDevice bleDevice, Uint8List result) {
//     onRecvNotifyMode_result = result;
//   }

//   @override
//   void onRecvSetDefaultMode(BleDevice bleDevice, bool result) {
//     onRecvSetDefaultMode_result = result;
//   }

//   @override
//   void onRecvGetDefaultMode(
//       BleDevice bleDevice, bool result, Uint8List defaultMode) {
//     onRecvGetDefaultMode_result = result;
//     onRecvGetDefaultMode_content = defaultMode;
//   }

//   @override
//   void onRecvSetLevel(BleDevice bleDevice, bool result, Uint8List level) {
//     onRecvSetLevel_result = result;
//     onRecvSetLevel_content = level;
//   }

//   @override
//   void onRecvGetLevel(BleDevice bleDevice, bool result, Uint8List level) {
//     onRecvGetLevel_result = result;
//     onRecvGetLevel_content = level;
//   }

//   @override
//   void onRecvNotifyLevel(BleDevice bleDevice, Uint8List level) {
//     onRecvNotifyLevel_result = level;
//   }

//   @override
//   void onRecvSetDefaultLevel(BleDevice bleDevice, bool result) {
//     onRecvSetDefaultLevel_result = result;
//   }

//   @override
//   void onRecvGetDefaultLevel(
//       BleDevice bleDevice, bool result, Uint8List defaultLevel) {
//     onRecvGetDefaultLevel_result = result;
//     onRecvGetDefaultLevel_content = defaultLevel;
//   }

//   @override
//   void onRecvSetTimeLen(BleDevice bleDevice, bool result, Uint8List timer) {
//     onRecvSetTimeLen_result = result;
//     onRecvSetTimeLen_content = timer;
//   }

//   @override
//   void onRecvGetTimeLen(BleDevice bleDevice, bool result, Uint8List timer) {
//     onRecvGetTimeLen_result = result;
//     onRecvGetTimeLen_content = timer;
//   }

//   @override
//   void onRecvNotifyTimeLen(BleDevice bleDevice, Uint8List timer) {
//     onRecvNotifyTimeLen_result = timer;
//   }

//   @override
//   void onRecvGetBatteryLevel(
//       BleDevice bleDevice, bool result, Uint8List batteryLevel) {
//     onRecvGetBatteryLevel_result = result;
//     onRecvGetBatteryLevel_content = batteryLevel;
//   }

//   @override
//   void onRecvNotifyBatteryLevel(BleDevice bleDevice, Uint8List batteryLevel) {
//     onRecvNotifyBatteryLevel_result = batteryLevel;
//   }

//   @override
//   void onRecvBigData(BleDevice device, bool result, Uint8List data) {
//     // TODO: implement onRecvBigData
//   }

//   @override
//   void onRecvPropertyCode(BleDevice device, bool result, Uint8List eikCode) {
//     // TODO: implement onRecvPropertyCode
//   }

//   /*
//   @override
//   void onRecvStartSession(bleDevice, content) {
//     bSessionEvent = true;
//     ekLog("onRecvStartSession................");
//   }

//   @override
//   void onRecvReadStatus(bleDevice, content) {
//     onRecvReadStatus_List = content;
//   }

//   @override
//   void onRecvSetDeviceName(bleDevice, result) {
//     onRecvSetDeviceName_result = result;
//   }

//   @override
//   void onRecvSetDevicePin(bleDevice, result) {
//     onRecvSetDevicePin_result = result;
//   }

// //buffer len(2b), buffer(n)
//   @override
//   void onRecvKeyAuth(bleDevice, content) {
//     onRecvKeyAuth_List = content;
//   }

//   @override
//   void onRecvReverseKeyAuth(bleDevice, content) {
//     // TODO: implement onRecvReverseKeyAuth
//   }
//   @override
//   void onRecvGetVersion(bleDevice, version) {
//     onRecvGetVersion_version = version;
//   }

//   @override
//   void onRecvSyncTime(bleDevice, result) {
//     onRecvSyncTime_result = result;
//   }

//   @override
//   void onRecvReadDeviceCode(bleDevice, content) {
//     onRecvReadDeviceCode_List = content;
//   }

//   @override
//   void onRecvSetModeParam(bleDevice, result) {
//     onRecvSetModeParam_result = result;
//   }

//   @override
//   void onRecvSetStrengthParam(bleDevice, result) {
//     onRecvSetStrengthParam_result = result;
//   }

//   @override
//   void onRecvSetTimeLenParams(bleDevice, result) {
//     onRecvSetTimeLenParams_result = result;
//   }

//   @override
//   void onRecvNotifyModeParam(bleDevice, mode) {
//     onRecvNotifyModeParam_mode = mode;
//   }

//   @override
//   void onRecvNotifyStrengthParam(bleDevice, strength) {
//     onRecvNotifyStrengthParam_strength = strength;
//   }

//   @override
//   void onRecvReadModeParam(bleDevice, mode) {
//     onRecvReadModeParam_mode = mode;
//   }

//   @override
//   void onRecvReadStrengthParam(bleDevice, strength) {
//     onRecvReadStrengthParam_strength = strength;
//   }

//   @override
//   void onRecvSetStart(bleDevice, result) {
//     onRecvSetStart_result = result;
//   }

//   @override
//   void onRecvSetStop(bleDevice, result) {
//     onRecvSetStop_result = result;
//   }

//   @override
//   void onRecvNotifyStart(bleDevice) {
//     onRecvNotifyStart_result = true;
//   }

//   @override
//   void onRecvNotifyStop(bleDevice) {
//     onRecvNotifyStop_result = true;
//   }

//   @override
//   void onRecvSetDefaultMode(bleDevice, result) {
//     onRecvSetDefaultMode_result = result;
//   }

//   @override
//   void onRecvReadDefaultModeParam(bleDevice, content) {
//     onRecvReadDefaultModeParam_List = content;
//   }

//   @override
//   void onRecvShutdown(bleDevice, result) {
//     onRecvShutdown_result = result;
//   }

//   @override
//   void onRecvNotifyShutdown(bleDevice, timeLeft) {
//     onRecvNotifyShutdown_timeLeft = timeLeft;
//   }

//   @override
//   void onRecvSetDeviceCode(bleDevice, result) {
//     onRecvSetDeviceCode_result = result;
//   }
//   */
// }

// /// platformName advName 目前是维护在FlutterBluePlus私有的map中
// /// 通过继承伪造name的数据返回，以便跑通测试案例
// const String _deviceName = 'MY-device';

// class _BluetoothDeviceM extends BluetoothDevice {
//   _BluetoothDeviceM({required super.remoteId});

//   @override
//   String get platformName => _deviceName;

//   @override
//   String get advName => _deviceName;
// }

// void main() {
//   group("handle response", () {
//     late BluetoothDevice blueToothDevice;

//     late WorkingDevice lockModel;
//     WorkingDevice workingDevice = WorkingDevice();

//     late BleDevice device;
//     StreamController<BluetoothConnectionState> bleStateController;
//     late CallbackTester dataCallbackTester;

//     setUpAll(() async {
//       Config.isUnitTest = true;
//       lockModel = Get.put(workingDevice);
//       await lockModel.onInit();
//       ekLog("lockModel hash=${lockModel.hashCode}");
//       MockFlutterBluePlus mockBluePlus = MockFlutterBluePlus();
//       //when(mockBluePlus.setLogLevel(LogLevel.debug)).thenReturn(0);

//       //BmBluetoothDevice proto = BmBluetoothDevice(remoteId: 'xxxxx', platformName: deviceName);
//       //blueToothDevice = BluetoothDevice.fromProto(proto);
//       blueToothDevice =
//           _BluetoothDeviceM(remoteId: const DeviceIdentifier('xxxxx'));

//       device = BleDevice(blueToothDevice);
//       var productConfig1 = ProductConfig(
//           'name',
//           'vtwhc3jovyzvd4h4',
//           'serviceUuid',
//           'characterUuid',
//           'characterUuid',
//           "MY-",
//           '0000af30-0000-1000-8000-00805f9b34fb');

//       Config.configList.clear();
//       Config.addProductConfig(productConfig1);
//       device.productConfig = productConfig1;

//       CommonProtoReceiver commonProtoReceiver =
//           BleDataChannel().commonProtoReceiver;
//       dataCallbackTester = CallbackTester();
//       commonProtoReceiver.setCallbackReceiver(dataCallbackTester);

//       lockModel.bindDevices.add(device);
//       ekLog('get ble device .....len=${lockModel.bindDevices.length}');
//     });

//     test("get device name - plain", () {
//       Config.gUseAesEncrypt = false;
//       handleRespond(
//           blueToothDevice, [0xa4, 5, 0, 0xb, 0x80, 0x01, 0, 1, 2, 3, 4]);
//       expect(dataCallbackTester.onRecvGetDeviceName_result, true);
//       expect(dataCallbackTester.onRecvGetDeviceName_content,
//           Uint8List.fromList([1, 2, 3, 4]));
//     });

//     test("get device name - encrypt", () {
//       Config.gUseAesEncrypt = true;
//       handleRespond(blueToothDevice, [
//         0xa5,
//         5,
//         0,
//         0xb,
//         0x76,
//         0xBD,
//         0x8F,
//         0xEE,
//         0xD9,
//         0x13,
//         0xE3,
//         0xEE,
//         0x25,
//         0x92,
//         0xC7,
//         0xD4,
//         0xD8,
//         0x6E,
//         0xCB,
//         0x7D
//       ]);
//       expect(dataCallbackTester.onRecvGetDeviceName_result, true);
//       expect(dataCallbackTester.onRecvGetDeviceName_content,
//           Uint8List.fromList([1, 2, 3, 4]));
//     });
//     test("set device name - plain", () {
//       Config.gUseAesEncrypt = false;
//       handleRespond(blueToothDevice, [0xa4, 5, 0, 0x07, 0x80, 0x02, 0]);
//       expect(dataCallbackTester.onRecvSetDeviceName_result, true);
//     });
//     test("set device name - encrypt", () {
//       Config.gUseAesEncrypt = true;
//       handleRespond(blueToothDevice, [
//         0xa5,
//         5,
//         0,
//         0x07,
//         0x43,
//         0x4E,
//         0x54,
//         0xBA,
//         0xDA,
//         0x3C,
//         0x60,
//         0x94,
//         0x45,
//         0x90,
//         0x07,
//         0xB2,
//         0x49,
//         0x89,
//         0x3E,
//         0x2E
//       ]);
//       expect(dataCallbackTester.onRecvSetDeviceName_result, true);
//     });

//     test("get eik code - plain", () {
//       Config.gUseAesEncrypt = false;
//       handleRespond(
//           blueToothDevice, [0xa4, 5, 0, 0x0c, 0x80, 0x03, 0, 1, 2, 3, 4, 5]);
//       expect(dataCallbackTester.onRecvGetEIKCode_result, true);
//       expect(dataCallbackTester.onRecvGetEIKCode_content,
//           Uint8List.fromList([1, 2, 3, 4, 5]));
//     });
//     test("get eik code - encrypt", () {
//       Config.gUseAesEncrypt = true;
//       handleRespond(blueToothDevice, [
//         0xa5,
//         5,
//         0,
//         0xc,
//         0xC0,
//         0xBD,
//         0x88,
//         0xFA,
//         0xF7,
//         0x55,
//         0x70,
//         0xAC,
//         0xCB,
//         0x44,
//         0xE9,
//         0x47,
//         0x82,
//         0x78,
//         0x4D,
//         0x23
//       ]);
//       expect(dataCallbackTester.onRecvGetEIKCode_result, true);
//       expect(dataCallbackTester.onRecvGetEIKCode_content,
//           Uint8List.fromList([1, 2, 3, 4, 5]));
//     });
//     test("get FW version - plain", () {
//       Config.gUseAesEncrypt = false;
//       handleRespond(
//           blueToothDevice, [0xa4, 5, 0, 0x0d, 0x80, 0x04, 0, 1, 2, 3, 4, 5, 6]);
//       expect(dataCallbackTester.onRecvGetFWVerison_result, true);
//       expect(dataCallbackTester.onRecvGetFWVerison_content,
//           Uint8List.fromList([1, 2, 3, 4, 5, 6]));
//     });
//     test("get FW version - encrypt", () {
//       Config.gUseAesEncrypt = true;
//       handleRespond(blueToothDevice, [
//         0xa5,
//         5,
//         0,
//         0xd,
//         0x45,
//         0xF5,
//         0x45,
//         0xC2,
//         0xA5,
//         0x4E,
//         0x26,
//         0xDC,
//         0x43,
//         0x68,
//         0xF1,
//         0x3D,
//         0x67,
//         0x8E,
//         0x2F,
//         0x08
//       ]);
//       expect(dataCallbackTester.onRecvGetFWVerison_result, true);
//       expect(dataCallbackTester.onRecvGetFWVerison_content,
//           Uint8List.fromList([1, 2, 3, 4, 5, 6]));
//     });
//     test("get sync time - plain", () {
//       Config.gUseAesEncrypt = false;
//       handleRespond(blueToothDevice, [0xa4, 5, 0, 0x07, 0x80, 0x05, 0]);
//       expect(dataCallbackTester.onRecvGetFWVerison_result, true);
//     });
//     test("get sync time - encrypt", () {
//       Config.gUseAesEncrypt = true;
//       handleRespond(blueToothDevice, [
//         0xa5,
//         5,
//         0,
//         0x7,
//         0xF5,
//         0x25,
//         0x47,
//         0x36,
//         0x12,
//         0xF7,
//         0x7B,
//         0x9B,
//         0x72,
//         0xB2,
//         0xD0,
//         0xE8,
//         0xDF,
//         0x5E,
//         0xDB,
//         0x9A
//       ]);
//       expect(dataCallbackTester.onRecvSyncTime_result, true);
//     });
//     test("set test flag - plain", () {
//       Config.gUseAesEncrypt = false;
//       handleRespond(blueToothDevice, [0xa4, 5, 0, 0x07, 0x80, 0x06, 0]);
//       expect(dataCallbackTester.onRecvSetTestFlag_result, true);
//     });
//     test("set test flag - encrypt", () {
//       Config.gUseAesEncrypt = true;
//       handleRespond(blueToothDevice, [
//         0xa5,
//         5,
//         0,
//         0x7,
//         0xA4,
//         0x16,
//         0xB6,
//         0x08,
//         0x27,
//         0x6D,
//         0xC7,
//         0x25,
//         0xB6,
//         0x84,
//         0xB6,
//         0xB4,
//         0x2D,
//         0xDC,
//         0x6C,
//         0x54
//       ]);
//       expect(dataCallbackTester.onRecvSetTestFlag_result, true);
//     });
//     test("get test flag - plain", () {
//       Config.gUseAesEncrypt = false;
//       handleRespond(blueToothDevice, [0xa4, 5, 0, 0x08, 0x80, 0x07, 0, 1]);
//       expect(dataCallbackTester.onRecvGetTestFlag_result, true);
//     });
//     test("get test flag - encrypt", () {
//       Config.gUseAesEncrypt = true;
//       handleRespond(blueToothDevice, [
//         0xa5,
//         5,
//         0,
//         0x8,
//         0xD9,
//         0x74,
//         0x3C,
//         0xFA,
//         0x18,
//         0x3D,
//         0x46,
//         0x2C,
//         0xA8,
//         0x8B,
//         0x00,
//         0xCA,
//         0xB2,
//         0x73,
//         0xC5,
//         0xFD
//       ]);
//       expect(dataCallbackTester.onRecvGetTestFlag_result, true);
//     });
//     test("get device status - plain", () {
//       Config.gUseAesEncrypt = false;
//       handleRespond(blueToothDevice, [
//         0xa4,
//         4,
//         0,
//         57,
//         0xa0,
//         0x00,
//         0,
//         1,
//         2,
//         3,
//         4,
//         5,
//         6,
//         7,
//         8,
//         9,
//         10,
//         11,
//         12,
//         13,
//       ]);
//       handleRespond(blueToothDevice, [
//         0xa4,
//         2,
//         0,
//         57,
//         0xa0,
//         0x00,
//         14,
//         15,
//         16,
//         17,
//         18,
//         19,
//         20,
//         21,
//         22,
//         23,
//         24,
//         25,
//         26,
//         27
//       ]);
//       handleRespond(blueToothDevice, [
//         0xa4,
//         2,
//         0,
//         57,
//         0xa0,
//         0x00,
//         28,
//         29,
//         30,
//         31,
//         32,
//         33,
//         34,
//         35,
//         36,
//         37,
//         38,
//         39,
//         40,
//         41
//       ]);
//       handleRespond(blueToothDevice,
//           [0xa4, 1, 0, 57, 0xa0, 0x00, 42, 43, 44, 45, 46, 47, 48, 49, 50]);
//       expect(dataCallbackTester.onRecvGetDeviceStatus_result, true);
//       expect(
//           dataCallbackTester.onRecvGetDeviceStatus_content,
//           Uint8List.fromList([
//             1,
//             2,
//             3,
//             4,
//             5,
//             6,
//             7,
//             8,
//             9,
//             10,
//             11,
//             12,
//             13,
//             14,
//             15,
//             16,
//             17,
//             18,
//             19,
//             20,
//             21,
//             22,
//             23,
//             24,
//             25,
//             26,
//             27,
//             28,
//             29,
//             30,
//             31,
//             32,
//             33,
//             34,
//             35,
//             36,
//             37,
//             38,
//             39,
//             40,
//             41,
//             42,
//             43,
//             44,
//             45,
//             46,
//             47,
//             48,
//             49,
//             50
//           ]));
//     });
//     // test("get device status - plain", () {
//     //   Config.gUseAesEncrypt = false;
//     //   handleRespond(blueToothDevice, [0xa4, 5, 0, 0x08, 0xa0, 0x00, 0, 1]);
//     //   expect(dataCallbackTester.onRecvGetDeviceStatus_result, true);
//     //   expect(dataCallbackTester.onRecvGetDeviceStatus_content,
//     //       Uint8List.fromList([1]));
//     // });
//     test("get device status - encrypt", () {
//       Config.gUseAesEncrypt = true;
//       handleRespond(blueToothDevice, [
//         0xa5,
//         4,
//         0,
//         57,
//         0x7F,
//         0xFD,
//         0xBC,
//         0x8D,
//         0xC8,
//         0x44,
//         0x1A,
//         0x21,
//         0x6E,
//         0x1C,
//         0x11,
//         0x20,
//         0xF5,
//         0xF3,
//         0x09,
//         0xB7
//       ]);
//       handleRespond(blueToothDevice, [
//         0xa5,
//         2,
//         0,
//         57,
//         0x44,
//         0xCA,
//         0x6A,
//         0x96,
//         0x67,
//         0xBD,
//         0x7C,
//         0xA1,
//         0x5B,
//         0x86,
//         0x80,
//         0x63,
//         0xF8,
//         0x5B,
//         0xA3,
//         0x21
//       ]);
//       handleRespond(blueToothDevice, [
//         0xa5,
//         2,
//         0,
//         57,
//         0x59,
//         0x96,
//         0xEB,
//         0xEF,
//         0x0C,
//         0x51,
//         0xD0,
//         0xE5,
//         0xA2,
//         0x3B,
//         0xEE,
//         0xE1,
//         0xD7,
//         0xA1,
//         0xD1,
//         0xF2
//       ]);
//       handleRespond(blueToothDevice, [
//         0xa5,
//         1,
//         0,
//         57,
//         0x48,
//         0xD5,
//         0x03,
//         0x81,
//         0x83,
//         0xB6,
//         0x03,
//         0x67,
//         0x6B,
//         0x1E,
//         0x26,
//         0x8D,
//         0x15,
//         0xB6,
//         0xCB,
//         0xFF
//       ]);
//       expect(dataCallbackTester.onRecvGetDeviceStatus_result, true);
//       expect(
//           dataCallbackTester.onRecvGetDeviceStatus_content,
//           Uint8List.fromList([
//             1,
//             2,
//             3,
//             4,
//             5,
//             6,
//             7,
//             8,
//             9,
//             10,
//             11,
//             12,
//             13,
//             14,
//             15,
//             16,
//             17,
//             18,
//             19,
//             20,
//             21,
//             22,
//             23,
//             24,
//             25,
//             26,
//             27,
//             28,
//             29,
//             30,
//             31,
//             32,
//             33,
//             34,
//             35,
//             36,
//             37,
//             38,
//             39,
//             40,
//             41,
//             42,
//             43,
//             44,
//             45,
//             46,
//             47,
//             48,
//             49,
//             50
//           ]));
//     });
//     // test("get device status - encrypt", () {
//     //   Config.gUseAesEncrypt = true;
//     //   handleRespond(blueToothDevice, [
//     //     0xa5,
//     //     5,
//     //     0,
//     //     0x8,
//     //     0xE4,
//     //     0x97,
//     //     0xF8,
//     //     0x7B,
//     //     0xD8,
//     //     0xAD,
//     //     0xF6,
//     //     0x7E,
//     //     0x07,
//     //     0xE2,
//     //     0xF0,
//     //     0xC9,
//     //     0x9E,
//     //     0xED,
//     //     0xC3,
//     //     0x0D
//     //   ]);
//     //   expect(dataCallbackTester.onRecvGetDeviceStatus_result, true);
//     //   expect(dataCallbackTester.onRecvGetDeviceStatus_content,
//     //       Uint8List.fromList([1]));
//     // });
//     test("set start - plain", () {
//       Config.gUseAesEncrypt = false;
//       handleRespond(blueToothDevice, [0xa4, 5, 0, 0x07, 0xa0, 0x01, 0]);
//       expect(dataCallbackTester.onRecvSetStart_result, true);
//     });
//     test("set start - encrypt", () {
//       Config.gUseAesEncrypt = true;
//       handleRespond(blueToothDevice, [
//         0xa5,
//         5,
//         0,
//         0x7,
//         0xB8,
//         0x57,
//         0x6E,
//         0x69,
//         0xD8,
//         0x57,
//         0xE6,
//         0x15,
//         0x0E,
//         0x78,
//         0x45,
//         0x3F,
//         0xCB,
//         0x4F,
//         0x35,
//         0x00
//       ]);
//       expect(dataCallbackTester.onRecvSetStart_result, true);
//     });
//     test("start notify - plain", () {
//       Config.gUseAesEncrypt = false;
//       handleRespond(blueToothDevice, [0xa4, 5, 0, 0x07, 0x20, 0x02, 0]);
//       expect(dataCallbackTester.onRecvNotifyStart_result, true);
//     });
//     test("start notify - encrypt", () {
//       Config.gUseAesEncrypt = true;
//       handleRespond(blueToothDevice, [
//         0xa5,
//         5,
//         0,
//         0x7,
//         0xB4,
//         0x40,
//         0x83,
//         0x2D,
//         0xB9,
//         0x64,
//         0x5B,
//         0x25,
//         0x07,
//         0x29,
//         0xE2,
//         0xDF,
//         0x73,
//         0x3F,
//         0xDD,
//         0xEE
//       ]);
//       expect(dataCallbackTester.onRecvNotifyStart_result, true);
//     });
//     test("pause - plain", () {
//       Config.gUseAesEncrypt = false;
//       handleRespond(blueToothDevice, [0xa4, 5, 0, 0x07, 0xa0, 0x03, 0]);
//       expect(dataCallbackTester.onRecvPause_result, true);
//     });
//     test("pause - encrypt", () {
//       Config.gUseAesEncrypt = true;
//       handleRespond(blueToothDevice, [
//         0xa5,
//         5,
//         0,
//         0x7,
//         0x56,
//         0xCA,
//         0xB9,
//         0x6F,
//         0x7B,
//         0xC6,
//         0x49,
//         0xA6,
//         0xEC,
//         0x67,
//         0xBB,
//         0xA6,
//         0x45,
//         0x69,
//         0x38,
//         0x49
//       ]);
//       expect(dataCallbackTester.onRecvPause_result, true);
//     });
//     test("pause notify - plain", () {
//       Config.gUseAesEncrypt = false;
//       handleRespond(blueToothDevice, [0xa4, 5, 0, 0x07, 0x20, 0x04, 0]);
//       // expect(dataCallbackTester.onRecvPauseNotify_result, true);
//     });
//     test("pause notify - encrypt", () {
//       Config.gUseAesEncrypt = true;
//       handleRespond(blueToothDevice, [
//         0xa5,
//         5,
//         0,
//         0x7,
//         0x96,
//         0xED,
//         0x51,
//         0x03,
//         0xAB,
//         0x91,
//         0xA6,
//         0xE2,
//         0x56,
//         0x35,
//         0xF9,
//         0x54,
//         0x04,
//         0x75,
//         0x4C,
//         0x98
//       ]);
//       // expect(dataCallbackTester.onRecvPauseNotify_result, true);
//     });
//     test("set stop - plain", () {
//       Config.gUseAesEncrypt = false;
//       handleRespond(blueToothDevice, [0xa4, 5, 0, 0x07, 0xa0, 0x05, 0]);
//       expect(dataCallbackTester.onRecvSetStop_result, true);
//     });
//     test("set stop - encrypt", () {
//       Config.gUseAesEncrypt = true;
//       handleRespond(blueToothDevice, [
//         0xa5,
//         5,
//         0,
//         0x7,
//         0x4E,
//         0xA3,
//         0x49,
//         0xEC,
//         0xBD,
//         0x61,
//         0x9F,
//         0x71,
//         0xCF,
//         0x9E,
//         0x12,
//         0x3B,
//         0x98,
//         0x12,
//         0xAA,
//         0x95
//       ]);
//       expect(dataCallbackTester.onRecvSetStop_result, true);
//     });
//     test("stop notify - plain", () {
//       Config.gUseAesEncrypt = false;
//       handleRespond(blueToothDevice, [0xa4, 5, 0, 0x07, 0x20, 0x06, 0]);
//       // expect(dataCallbackTester.onRecvNotifyStop_result, true);
//     });
//     test("stop notify - encrypt", () {
//       Config.gUseAesEncrypt = true;
//       handleRespond(blueToothDevice, [
//         0xa5,
//         5,
//         0,
//         0x7,
//         0xD2,
//         0xAC,
//         0x1A,
//         0x23,
//         0x11,
//         0xBC,
//         0xFB,
//         0x8F,
//         0x85,
//         0xD1,
//         0xEA,
//         0xA6,
//         0x23,
//         0x93,
//         0xD0,
//         0x13
//       ]);
//       // expect(dataCallbackTester.onRecvNotifyStop_result, true);
//     });
//     test("shutdown - plain", () {
//       Config.gUseAesEncrypt = false;
//       handleRespond(blueToothDevice, [0xa4, 5, 0, 0x07, 0xa0, 0x07, 0]);
//       expect(dataCallbackTester.onRecvShutdown_result, true);
//     });
//     test("shutdown - encrypt", () {
//       Config.gUseAesEncrypt = true;
//       handleRespond(blueToothDevice, [
//         0xa5,
//         5,
//         0,
//         0x7,
//         0x62,
//         0x8F,
//         0xA2,
//         0xBC,
//         0xC7,
//         0xEF,
//         0xF5,
//         0x3C,
//         0xE5,
//         0x31,
//         0x5E,
//         0x18,
//         0x95,
//         0x53,
//         0x17,
//         0x51
//       ]);
//       expect(dataCallbackTester.onRecvShutdown_result, true);
//     });
//     test("notify shutdown - plain", () {
//       Config.gUseAesEncrypt = false;
//       handleRespond(blueToothDevice, [0xa4, 5, 0, 0x07, 0x20, 0x08, 0]);
//       //expect(dataCallbackTester.onRecvNotifyShutdown_result, true);
//     });
//     test("notify shutdown - encrypt", () {
//       Config.gUseAesEncrypt = true;
//       handleRespond(blueToothDevice, [
//         0xa5,
//         5,
//         0,
//         0x7,
//         0x07,
//         0x04,
//         0x21,
//         0x62,
//         0x76,
//         0xF7,
//         0xFE,
//         0x31,
//         0x99,
//         0x29,
//         0x2C,
//         0xE7,
//         0xBB,
//         0x88,
//         0xB3,
//         0xF0
//       ]);
//       // expect(dataCallbackTester.onRecvNotifyShutdown_result, true);
//     });
//     test("set mode - plain", () {
//       Config.gUseAesEncrypt = false;
//       handleRespond(blueToothDevice, [0xa4, 5, 0, 0x08, 0xa0, 0x0a, 0, 1]);
//       expect(dataCallbackTester.onRecvSetMode_result, true);
//       expect(dataCallbackTester.onRecvSetMode_content, Uint8List.fromList([1]));
//     });
//     test("set mode - encrypt", () {
//       Config.gUseAesEncrypt = true;
//       handleRespond(blueToothDevice, [
//         0xa5,
//         5,
//         0,
//         0x8,
//         0x8B,
//         0x98,
//         0x39,
//         0xA4,
//         0x1E,
//         0x39,
//         0x45,
//         0x3F,
//         0x98,
//         0x0A,
//         0x59,
//         0xE1,
//         0x1D,
//         0x9E,
//         0x0B,
//         0xFD
//       ]);
//       expect(dataCallbackTester.onRecvSetMode_result, true);
//       expect(dataCallbackTester.onRecvSetMode_content, Uint8List.fromList([1]));
//     });
//     test("get mode - plain", () {
//       Config.gUseAesEncrypt = false;
//       handleRespond(blueToothDevice, [0xa4, 5, 0, 0x08, 0xa0, 0x0b, 0, 1]);
//       expect(dataCallbackTester.onRecvGetMode_result, true);
//       expect(dataCallbackTester.onRecvGetMode_content, Uint8List.fromList([1]));
//     });
//     test("get mode - encrypt", () {
//       Config.gUseAesEncrypt = true;
//       handleRespond(blueToothDevice, [
//         0xa5,
//         5,
//         0,
//         0x8,
//         0xD4,
//         0x14,
//         0xD3,
//         0xB2,
//         0xA3,
//         0xC4,
//         0x85,
//         0x42,
//         0x67,
//         0x43,
//         0x3D,
//         0xDB,
//         0x2A,
//         0x50,
//         0xF7,
//         0xBA
//       ]);
//       expect(dataCallbackTester.onRecvGetMode_result, true);
//       expect(dataCallbackTester.onRecvGetMode_content, Uint8List.fromList([1]));
//     });
//     test("notify mode - plain", () {
//       Config.gUseAesEncrypt = false;
//       handleRespond(blueToothDevice, [0xa4, 5, 0, 0x07, 0x20, 0x0c, 0]);
//       expect(dataCallbackTester.onRecvNotifyMode_result, true);
//     });
//     test("notify mode - encrypt", () {
//       Config.gUseAesEncrypt = true;
//       handleRespond(blueToothDevice, [
//         0xa5,
//         5,
//         0,
//         0x7,
//         0x9B,
//         0x82,
//         0x4F,
//         0x62,
//         0xFB,
//         0xAB,
//         0x0E,
//         0xBC,
//         0x2D,
//         0xD5,
//         0xDC,
//         0x71,
//         0xDE,
//         0x8A,
//         0xD0,
//         0x0A
//       ]);
//       expect(dataCallbackTester.onRecvNotifyMode_result, true);
//     });
//     test("set default mode - plain", () {
//       Config.gUseAesEncrypt = false;
//       handleRespond(blueToothDevice, [0xa4, 5, 0, 0x07, 0xa0, 0x0d, 0]);
//       expect(dataCallbackTester.onRecvSetDefaultMode_result, true);
//     });
//     test("set default mode - encrypt", () {
//       Config.gUseAesEncrypt = true;
//       handleRespond(blueToothDevice, [
//         0xa5,
//         5,
//         0,
//         0x7,
//         0x81,
//         0x14,
//         0x43,
//         0x12,
//         0x53,
//         0x3C,
//         0x25,
//         0x72,
//         0x4A,
//         0x64,
//         0x26,
//         0x92,
//         0x47,
//         0xAC,
//         0xD0,
//         0xB9
//       ]);
//       expect(dataCallbackTester.onRecvSetDefaultMode_result, true);
//     });
//     test("get default mode - plain", () {
//       Config.gUseAesEncrypt = false;
//       handleRespond(blueToothDevice, [0xa4, 5, 0, 0x08, 0xa0, 0x0e, 0, 1]);
//       expect(dataCallbackTester.onRecvGetDefaultMode_result, true);
//       expect(dataCallbackTester.onRecvGetDefaultMode_content,
//           Uint8List.fromList([1]));
//     });
//     test("get default mode - encrypt", () {
//       Config.gUseAesEncrypt = true;
//       handleRespond(blueToothDevice, [
//         0xa5,
//         5,
//         0,
//         0x8,
//         0x89,
//         0x1C,
//         0x4F,
//         0x4C,
//         0x90,
//         0xDE,
//         0x81,
//         0x67,
//         0xA9,
//         0xFB,
//         0xDD,
//         0x6F,
//         0x25,
//         0x68,
//         0xFA,
//         0x7C
//       ]);
//       expect(dataCallbackTester.onRecvGetDefaultMode_result, true);
//       expect(dataCallbackTester.onRecvGetDefaultMode_content,
//           Uint8List.fromList([1]));
//     });
//     test("set level - plain", () {
//       Config.gUseAesEncrypt = false;
//       handleRespond(blueToothDevice, [0xa4, 5, 0, 0x08, 0xa0, 0x0f, 0, 1]);
//       expect(dataCallbackTester.onRecvSetLevel_result, true);
//       expect(
//           dataCallbackTester.onRecvSetLevel_content, Uint8List.fromList([1]));
//     });
//     test("set level - encrypt", () {
//       Config.gUseAesEncrypt = true;
//       handleRespond(blueToothDevice, [
//         0xa5,
//         5,
//         0,
//         0x8,
//         0xE8,
//         0x85,
//         0x44,
//         0xD3,
//         0xB4,
//         0x1C,
//         0x3A,
//         0x24,
//         0xC0,
//         0x65,
//         0x21,
//         0xFA,
//         0xD7,
//         0xAD,
//         0xA5,
//         0xCF
//       ]);
//       expect(dataCallbackTester.onRecvSetLevel_result, true);
//       expect(
//           dataCallbackTester.onRecvSetLevel_content, Uint8List.fromList([1]));
//     });
//     test("get level - plain", () {
//       Config.gUseAesEncrypt = false;
//       handleRespond(blueToothDevice, [0xa4, 5, 0, 0x08, 0xa0, 0x10, 0, 1]);
//       expect(dataCallbackTester.onRecvGetLevel_result, true);
//       expect(
//           dataCallbackTester.onRecvGetLevel_content, Uint8List.fromList([1]));
//     });
//     test("get level - encrypt", () {
//       Config.gUseAesEncrypt = true;
//       handleRespond(blueToothDevice, [
//         0xa5,
//         5,
//         0,
//         0x8,
//         0xFA,
//         0x44,
//         0x44,
//         0xA5,
//         0xFC,
//         0x56,
//         0x30,
//         0x98,
//         0xAD,
//         0x5E,
//         0x78,
//         0xE6,
//         0x8A,
//         0xB0,
//         0xC1,
//         0x05
//       ]);
//       expect(dataCallbackTester.onRecvGetLevel_result, true);
//       expect(
//           dataCallbackTester.onRecvGetLevel_content, Uint8List.fromList([1]));
//     });
//     test("notify level - plain", () {
//       Config.gUseAesEncrypt = false;
//       handleRespond(blueToothDevice, [0xa4, 5, 0, 0x07, 0x20, 0x11, 0]);
//       expect(dataCallbackTester.onRecvNotifyLevel_result, true);
//     });
//     test("notify level - encrypt", () {
//       Config.gUseAesEncrypt = true;
//       handleRespond(blueToothDevice, [
//         0xa5,
//         5,
//         0,
//         0x7,
//         0xE8,
//         0x76,
//         0x6B,
//         0xC0,
//         0x8E,
//         0x6D,
//         0xCD,
//         0xAB,
//         0xD3,
//         0x1D,
//         0x6C,
//         0xB2,
//         0x76,
//         0xA0,
//         0xCA,
//         0x98
//       ]);
//       expect(dataCallbackTester.onRecvNotifyLevel_result, true);
//     });
//     test("set default level - plain", () {
//       Config.gUseAesEncrypt = false;
//       handleRespond(blueToothDevice, [0xa4, 5, 0, 0x07, 0xa0, 0x12, 0]);
//       expect(dataCallbackTester.onRecvSetDefaultLevel_result, true);
//     });
//     test("set default level - encrypt", () {
//       Config.gUseAesEncrypt = true;
//       handleRespond(blueToothDevice, [
//         0xa5,
//         5,
//         0,
//         0x7,
//         0xC9,
//         0x5F,
//         0xC6,
//         0xE9,
//         0x53,
//         0x38,
//         0x9B,
//         0x7D,
//         0x44,
//         0x77,
//         0x4A,
//         0xC8,
//         0xA0,
//         0xD9,
//         0x06,
//         0x50
//       ]);
//       expect(dataCallbackTester.onRecvSetDefaultLevel_result, true);
//     });
//     test("get default level - plain", () {
//       Config.gUseAesEncrypt = false;
//       handleRespond(blueToothDevice, [0xa4, 5, 0, 0x08, 0xa0, 0x13, 0, 1]);
//       expect(dataCallbackTester.onRecvGetDefaultLevel_result, true);
//       expect(dataCallbackTester.onRecvGetDefaultLevel_content,
//           Uint8List.fromList([1]));
//     });
//     test("get default level - encrypt", () {
//       Config.gUseAesEncrypt = true;
//       handleRespond(blueToothDevice, [
//         0xa5,
//         5,
//         0,
//         0x8,
//         0x00,
//         0xB4,
//         0xF5,
//         0x3C,
//         0x98,
//         0x93,
//         0x55,
//         0xB5,
//         0x08,
//         0x92,
//         0x55,
//         0x67,
//         0x44,
//         0x10,
//         0xC4,
//         0xCA
//       ]);
//       expect(dataCallbackTester.onRecvGetDefaultLevel_result, true);
//       expect(dataCallbackTester.onRecvGetDefaultLevel_content,
//           Uint8List.fromList([1]));
//     });
//     test("set timer - plain", () {
//       Config.gUseAesEncrypt = false;
//       handleRespond(blueToothDevice, [0xa4, 5, 0, 0x08, 0xa0, 0x14, 0, 1]);
//       expect(dataCallbackTester.onRecvSetTimeLen_result, true);
//       expect(
//           dataCallbackTester.onRecvSetTimeLen_content, Uint8List.fromList([1]));
//     });
//     test("set timer - encrypt", () {
//       Config.gUseAesEncrypt = true;
//       handleRespond(blueToothDevice, [
//         0xa5,
//         5,
//         0,
//         0x8,
//         0x82,
//         0xF2,
//         0xD4,
//         0x18,
//         0xAA,
//         0xA9,
//         0xAF,
//         0x34,
//         0xD4,
//         0xDB,
//         0x57,
//         0x4A,
//         0x0D,
//         0xDD,
//         0x2E,
//         0xBE
//       ]);
//       expect(dataCallbackTester.onRecvSetTimeLen_result, true);
//       expect(
//           dataCallbackTester.onRecvSetTimeLen_content, Uint8List.fromList([1]));
//     });
//     test("get timer - plain", () {
//       Config.gUseAesEncrypt = false;
//       handleRespond(blueToothDevice, [0xa4, 5, 0, 0x08, 0xa0, 0x15, 0, 1]);
//       expect(dataCallbackTester.onRecvGetTimeLen_result, true);
//       expect(
//           dataCallbackTester.onRecvGetTimeLen_content, Uint8List.fromList([1]));
//     });
//     test("get timer - encrypt", () {
//       Config.gUseAesEncrypt = true;
//       handleRespond(blueToothDevice, [
//         0xa5,
//         5,
//         0,
//         0x8,
//         0xB2,
//         0x03,
//         0x7D,
//         0x7D,
//         0x4A,
//         0x8D,
//         0x21,
//         0xCB,
//         0xF8,
//         0x8E,
//         0x73,
//         0x42,
//         0xBC,
//         0x23,
//         0x8C,
//         0x4F
//       ]);
//       expect(dataCallbackTester.onRecvGetTimeLen_result, true);
//       expect(
//           dataCallbackTester.onRecvGetTimeLen_content, Uint8List.fromList([1]));
//     });
//     test("notify timer - plain", () {
//       Config.gUseAesEncrypt = false;
//       handleRespond(blueToothDevice, [0xa4, 5, 0, 0x07, 0x20, 0x16, 0]);
//       expect(dataCallbackTester.onRecvNotifyTimeLen_result, true);
//     });
//     test("notify timer - encrypt", () {
//       Config.gUseAesEncrypt = true;
//       handleRespond(blueToothDevice, [
//         0xa5,
//         5,
//         0,
//         0x7,
//         0xF1,
//         0x2B,
//         0xCE,
//         0x34,
//         0xFA,
//         0x84,
//         0x7E,
//         0x60,
//         0x00,
//         0xC8,
//         0xA5,
//         0x76,
//         0x23,
//         0x53,
//         0xA5,
//         0xAA
//       ]);
//       expect(dataCallbackTester.onRecvNotifyTimeLen_result, true);
//     });
//     test("get battery level - plain", () {
//       Config.gUseAesEncrypt = false;
//       handleRespond(blueToothDevice, [0xa4, 5, 0, 0x08, 0xa0, 0x17, 0, 1]);
//       expect(dataCallbackTester.onRecvGetBatteryLevel_result, true);
//       expect(dataCallbackTester.onRecvGetBatteryLevel_content,
//           Uint8List.fromList([1]));
//     });
//     test("get battery level - encrypt", () {
//       Config.gUseAesEncrypt = true;
//       handleRespond(blueToothDevice, [
//         0xa5,
//         5,
//         0,
//         0x8,
//         0x5D,
//         0x75,
//         0xA3,
//         0xF8,
//         0x2B,
//         0x80,
//         0x5C,
//         0xBA,
//         0x98,
//         0x53,
//         0x86,
//         0x89,
//         0x95,
//         0xB5,
//         0xA7,
//         0xC4
//       ]);
//       expect(dataCallbackTester.onRecvGetBatteryLevel_result, true);
//       expect(dataCallbackTester.onRecvGetBatteryLevel_content,
//           Uint8List.fromList([1]));
//     });
//     test("notify battery level - plain", () {
//       Config.gUseAesEncrypt = false;
//       handleRespond(blueToothDevice, [0xa4, 5, 0, 0x07, 0x20, 0x18, 0]);
//       expect(dataCallbackTester.onRecvNotifyBatteryLevel_result, true);
//     });
//     test("notify battery level - encrypt", () {
//       Config.gUseAesEncrypt = true;
//       handleRespond(blueToothDevice, [
//         0xa5,
//         5,
//         0,
//         0x7,
//         0x3F,
//         0xBD,
//         0x43,
//         0x59,
//         0x5B,
//         0xA9,
//         0x60,
//         0xC9,
//         0x37,
//         0x06,
//         0x47,
//         0x50,
//         0x1C,
//         0xAC,
//         0xA4,
//         0xEF
//       ]);
//       expect(dataCallbackTester.onRecvNotifyBatteryLevel_result, true);
//     });
//     /*

//     test("get ble device", () {
//       lockModel = Get.put(workingDevice);
//       ekLog("lockModel hash=${lockModel.hashCode}");
//       ekLog('get ble device .....len=${lockModel.bindDevices.length}');
//       BleDevice? bleDevice = lockModel.getByBleRawDevice(blueToothDevice);

//       expect(bleDevice, isNotNull);
//       expect(bleDevice!.device!.remoteId, const DeviceIdentifier('xxxxx'));
//     });

//     test("read status - plain", () {
//       Config.gUseAesEncrypt = false;
//       handleRespond(blueToothDevice, [
//         0xBB,
//         0x45,
//         0xFE,
//         0x35,
//         0x09,
//         0xF4,
//         0x7B,
//         0xDC,
//         0xEC,
//         0x29,
//         0xEA,
//         0x4B,
//         0x20,
//         0x8F,
//         0x74,
//         0xB0
//       ]);
//       expect(
//           dataCallbackTester.onRecvReadStatus_List, [0x01, 0x01, 0x01, 0x01]);
//     });

//     test("set device name", () {
//       Config.gUseAesEncrypt = true;
//       handleRespond(blueToothDevice, [
//         0x71,
//         0xAF,
//         0x49,
//         0x60,
//         0x36,
//         0x18,
//         0x24,
//         0xA5,
//         0xDE,
//         0xCB,
//         0xD8,
//         0x52,
//         0x41,
//         0x11,
//         0x2D,
//         0xCD
//       ]);

//       expect(dataCallbackTester.onRecvSetDeviceName_result, true);
//     });
//     test("set device pin", () {
//       Config.gUseAesEncrypt = true;
//       handleRespond(blueToothDevice, [
//         0x9E,
//         0x17,
//         0x7A,
//         0x9E,
//         0x72,
//         0xCB,
//         0xED,
//         0xD7,
//         0x46,
//         0x54,
//         0x9C,
//         0xF1,
//         0x45,
//         0x3B,
//         0x62,
//         0xF5
//       ]);
//       expect(dataCallbackTester.onRecvSetDevicePin_result, false);
//     });

//     test("key auth", () {
//       Config.gUseAesEncrypt = true;
//       var mock1 = Uint8List.fromList([
//         0xA5,
//         0xA5,
//         0x01,
//         0x04,
//         0x00,
//         0x0F,
//         0x00,
//         0x04,
//         0x00,
//         0x12,
//         0x02,
//         0x03,
//         0x04,
//         0x05,
//         0x82
//       ]);
//       var mock2 = Uint8List.fromList([
//         0xA5,
//         0xA5,
//         0x01,
//         0x02,
//         0x00,
//         0x0F,
//         0x00,
//         0x04,
//         0x06,
//         0x07,
//         0x08,
//         0x09,
//         0x10,
//         0x11,
//         0x9f
//       ]);
//       var mock3 = Uint8List.fromList([
//         0xA5,
//         0xA5,
//         0x01,
//         0x01,
//         0x00,
//         0x0F,
//         0x00,
//         0x04,
//         0x12,
//         0x13,
//         0x14,
//         0x15,
//         0x16,
//         0x17,
//         0xda
//       ]);
//       handleRespond(blueToothDevice, [
//         0x7D,
//         0x7E,
//         0xA7,
//         0x14,
//         0xFE,
//         0xF3,
//         0x88,
//         0xBB,
//         0xD0,
//         0x2F,
//         0x61,
//         0xE8,
//         0x68,
//         0x6F,
//         0xAA,
//         0xD5
//       ]);
//       handleRespond(blueToothDevice, [
//         0x9F,
//         0x2B,
//         0x2E,
//         0x80,
//         0x10,
//         0x5A,
//         0xF6,
//         0x47,
//         0xCC,
//         0x1C,
//         0xC8,
//         0x96,
//         0x5D,
//         0x16,
//         0x60,
//         0x34
//       ]);
//       handleRespond(blueToothDevice, [
//         0x9D,
//         0x26,
//         0x59,
//         0x36,
//         0x67,
//         0x8E,
//         0x7F,
//         0x9A,
//         0x71,
//         0xC4,
//         0x7D,
//         0x09,
//         0xD5,
//         0x89,
//         0x56,
//         0xF1
//       ]);
//       expect(dataCallbackTester.onRecvKeyAuth_List, [
//         0x02,
//         0x03,
//         0x04,
//         0x05,
//         0x06,
//         0x07,
//         0x08,
//         0x09,
//         0x10,
//         0x11,
//         0x12,
//         0x13,
//         0x14,
//         0x15,
//         0x16,
//         0x17
//       ]);
//     });
//     test("reverse key auth", () {
//       Config.gUseAesEncrypt = true;
//       var mock = Uint8List.fromList([
//         0xEE,
//         0x00,
//         0x0C,
//         0x04,
//         0x12,
//         0x23,
//         0x34,
//         0x45,
//         0x02,
//         0x11,
//         0x22,
//         0xE1
//       ]);
//       handleRespond(blueToothDevice, []);
//     });

//     test("get version", () {
//       Config.gUseAesEncrypt = true;
//       // var versionToEncode = utf8.encode("V1.0.0");
//       // for (int i = 0; i < versionToEncode.length; i++) {
//       //   ekLog(versionToEncode[i].toRadixString(16));
//       // }
//       handleRespond(blueToothDevice, [
//         0x1D,
//         0x42,
//         0x31,
//         0x7E,
//         0x8A,
//         0x5E,
//         0x1E,
//         0x2B,
//         0xF5,
//         0x85,
//         0xF9,
//         0x2B,
//         0x93,
//         0xE3,
//         0x8F,
//         0x12,
//         0x3D,
//         0x0F,
//         0x27,
//         0x8F,
//         0xC6,
//         0xAF,
//         0xD1,
//         0xDC,
//         0x87,
//         0x3A,
//         0x50,
//         0x8F,
//         0xC4,
//         0x06,
//         0x54,
//         0x12
//       ]);

//       expect(dataCallbackTester.onRecvGetVersion_version, 'V1.0.0');
//     });
//     test("syn time", () {
//       Config.gUseAesEncrypt = true;
//       handleRespond(blueToothDevice, [
//         0x7E,
//         0x4C,
//         0x86,
//         0x47,
//         0xF4,
//         0xF5,
//         0x4F,
//         0x43,
//         0xA9,
//         0x3B,
//         0xCD,
//         0x3E,
//         0xE1,
//         0x33,
//         0xE3,
//         0xB9
//       ]);
//       expect(dataCallbackTester.onRecvSyncTime_result, true);
//     });
//     test("read device code", () {
//       Config.gUseAesEncrypt = true;
//       handleRespond(blueToothDevice, [
//         0x35,
//         0x81,
//         0xE6,
//         0xF8,
//         0xB0,
//         0x7A,
//         0x8A,
//         0xDE,
//         0xF9,
//         0x98,
//         0xC7,
//         0xB9,
//         0x4F,
//         0xC6,
//         0x51,
//         0x3B,
//         0x75,
//         0xE3,
//         0x25,
//         0xAE,
//         0x92,
//         0xEF,
//         0x34,
//         0x9B,
//         0x0D,
//         0xB0,
//         0x13,
//         0x25,
//         0xC3,
//         0x31,
//         0x4E,
//         0x16
//       ]);

//       expect(dataCallbackTester.onRecvReadDeviceCode_List, [
//         0x01,
//         0x0,
//         0x0A,
//         0x11,
//         0x22,
//         0x33,
//         0x44,
//         0x55,
//         0x66,
//         0x77,
//         0x88,
//         0x99,
//         0xAA
//       ]);
//     });
//     test("set mode", () {
//       Config.gUseAesEncrypt = true;
//       handleRespond(blueToothDevice, [
//         0x48,
//         0x7E,
//         0x5A,
//         0x60,
//         0x6D,
//         0xEC,
//         0xC9,
//         0xA5,
//         0xF2,
//         0x89,
//         0x7C,
//         0xF1,
//         0x64,
//         0x53,
//         0x1B,
//         0x03
//       ]);
//       expect(dataCallbackTester.onRecvSetModeParam_result, true);
//     });
//     test("set strength", () {
//       Config.gUseAesEncrypt = true;
//       handleRespond(blueToothDevice, [
//         0x33,
//         0xCF,
//         0x63,
//         0x09,
//         0x55,
//         0x7B,
//         0x6F,
//         0x08,
//         0xD1,
//         0x88,
//         0x3B,
//         0x61,
//         0x49,
//         0xD2,
//         0x02,
//         0x91
//       ]);
//       expect(dataCallbackTester.onRecvSetStrengthParam_result, true);
//     });
//     test("set time Len", () {
//       Config.gUseAesEncrypt = true;
//       handleRespond(blueToothDevice, [
//         0x78,
//         0x58,
//         0x55,
//         0x6B,
//         0xA0,
//         0x54,
//         0x88,
//         0x9B,
//         0xCC,
//         0x2A,
//         0xC6,
//         0x99,
//         0x8D,
//         0x73,
//         0x4C,
//         0x65
//       ]);
//       expect(dataCallbackTester.onRecvSetTimeLenParams_result, true);
//     });
//     test("notify mode", () {
//       Config.gUseAesEncrypt = true;
//       handleRespond(blueToothDevice, [
//         0x11,
//         0x4C,
//         0xA3,
//         0x92,
//         0x20,
//         0xD7,
//         0xB3,
//         0x8E,
//         0x88,
//         0x0B,
//         0x1B,
//         0xB6,
//         0x85,
//         0x1E,
//         0x5C,
//         0x70
//       ]);
//       expect(dataCallbackTester.onRecvNotifyModeParam_mode, 2);
//     });
//     test("notify strength", () {
//       Config.gUseAesEncrypt = true;
//       handleRespond(blueToothDevice, [
//         0x97,
//         0x50,
//         0xEA,
//         0x43,
//         0xAB,
//         0x80,
//         0x80,
//         0x64,
//         0x7A,
//         0x9C,
//         0x5C,
//         0xB6,
//         0xBE,
//         0x22,
//         0xAA,
//         0x72
//       ]);
//       expect(dataCallbackTester.onRecvNotifyStrengthParam_strength, 2);
//     });
//     test("read mode", () {
//       Config.gUseAesEncrypt = true;
//       handleRespond(blueToothDevice, [
//         0xE6,
//         0x45,
//         0xD6,
//         0x38,
//         0xE8,
//         0x8F,
//         0xA2,
//         0x3A,
//         0x78,
//         0xBC,
//         0x1E,
//         0x14,
//         0x63,
//         0x37,
//         0xE7,
//         0x41
//       ]);
//       expect(dataCallbackTester.onRecvReadModeParam_mode, 2);
//     });
//     test("read strength", () {
//       Config.gUseAesEncrypt = true;
//       handleRespond(blueToothDevice, [
//         0x03,
//         0x41,
//         0x54,
//         0x09,
//         0xDC,
//         0xA0,
//         0xC4,
//         0x42,
//         0xBE,
//         0x1F,
//         0x1F,
//         0x4C,
//         0x53,
//         0x5F,
//         0x86,
//         0xB2
//       ]);
//       expect(dataCallbackTester.onRecvReadStrengthParam_strength, 2);
//     });
//     test("set start", () {
//       Config.gUseAesEncrypt = true;
//       handleRespond(blueToothDevice, [
//         0x88,
//         0xE6,
//         0xE4,
//         0xBA,
//         0x2F,
//         0x73,
//         0x50,
//         0xF8,
//         0x35,
//         0xEA,
//         0x83,
//         0xEF,
//         0xEC,
//         0xF1,
//         0xBC,
//         0xF5
//       ]);
//       expect(dataCallbackTester.onRecvSetStart_result, true);
//     });
//     test("set stop", () {
//       Config.gUseAesEncrypt = true;
//       handleRespond(blueToothDevice, [
//         0x3C,
//         0x4F,
//         0xF2,
//         0xB2,
//         0x05,
//         0xBF,
//         0x15,
//         0xCA,
//         0x41,
//         0x64,
//         0xDA,
//         0x12,
//         0x35,
//         0x16,
//         0x80,
//         0xC2
//       ]);
//       expect(dataCallbackTester.onRecvSetStop_result, true);
//     });

//     test("notify start", () {
//       Config.gUseAesEncrypt = true;
//       handleRespond(blueToothDevice, [
//         0x06,
//         0xBC,
//         0x05,
//         0x83,
//         0x01,
//         0x06,
//         0xB6,
//         0x8D,
//         0xC8,
//         0x38,
//         0xB2,
//         0x39,
//         0xB8,
//         0x9A,
//         0x21,
//         0x00
//       ]);
//       expect(dataCallbackTester.onRecvNotifyStart_result, true);
//     });
//     test("notify stop", () {
//       Config.gUseAesEncrypt = true;
//       handleRespond(blueToothDevice, [
//         0x03,
//         0x56,
//         0x22,
//         0xEE,
//         0xB3,
//         0x4E,
//         0xB1,
//         0xD0,
//         0xA3,
//         0xC7,
//         0xAE,
//         0x2B,
//         0xF6,
//         0xC4,
//         0x21,
//         0xC3
//       ]);
//       expect(dataCallbackTester.onRecvNotifyStop_result, true);
//     });
//     test("set default mode", () {
//       Config.gUseAesEncrypt = true;
//       handleRespond(blueToothDevice, [
//         0x27,
//         0xF7,
//         0xA8,
//         0x71,
//         0x22,
//         0xF6,
//         0xD7,
//         0xA8,
//         0xD1,
//         0x66,
//         0x56,
//         0x82,
//         0x1B,
//         0x5F,
//         0x04,
//         0x86
//       ]);
//       expect(dataCallbackTester.onRecvSetDefaultMode_result, true);
//     });
//     test("read default mode", () {
//       Config.gUseAesEncrypt = true;
//       handleRespond(blueToothDevice, [
//         0xF8,
//         0xA1,
//         0x17,
//         0xC5,
//         0x11,
//         0x86,
//         0x39,
//         0x5D,
//         0xCE,
//         0xD5,
//         0x3E,
//         0xD9,
//         0xA1,
//         0xE3,
//         0xF9,
//         0x34
//       ]);
//       expect(dataCallbackTester.onRecvReadDefaultModeParam_List,
//           [0x01, 0x02, 0x03]);
//     });
//     test("shutdown", () {
//       Config.gUseAesEncrypt = true;
//       handleRespond(blueToothDevice, [
//         0xC7,
//         0xBC,
//         0x93,
//         0xB1,
//         0x7F,
//         0x69,
//         0x48,
//         0x0A,
//         0x6F,
//         0xC0,
//         0xEF,
//         0xAE,
//         0x83,
//         0x7F,
//         0xB0,
//         0x83
//       ]);
//       expect(dataCallbackTester.onRecvShutdown_result, true);
//     });
//     test("notify shutdown", () {
//       Config.gUseAesEncrypt = true;
//       handleRespond(blueToothDevice, [
//         0x40,
//         0xE7,
//         0x0D,
//         0x7A,
//         0xD4,
//         0x57,
//         0xC0,
//         0xC4,
//         0x3E,
//         0x92,
//         0xD0,
//         0xF5,
//         0x96,
//         0x2F,
//         0x24,
//         0x34
//       ]);
//       expect(dataCallbackTester.onRecvNotifyShutdown_timeLeft, 1);
//     });
//     test("set device code", () {
//       Config.gUseAesEncrypt = true;
//       handleRespond(blueToothDevice, [
//         0x5B,
//         0x2B,
//         0x16,
//         0xCD,
//         0x79,
//         0x5F,
//         0x31,
//         0xB0,
//         0x41,
//         0x64,
//         0x66,
//         0x1C,
//         0x93,
//         0x7A,
//         0x69,
//         0x80
//       ]);
//       expect(dataCallbackTester.onRecvSetDeviceCode_result, true);
//     });

//     test("description", () {
//       List<int> l = [];
//       l.add(2);
//       expect(1, 1);
//     });

//     tearDownAll(() {
//       ekLog('tear down.....');

//       Config.isUnitTest = false;
//     });
//     */
//   });
// }
