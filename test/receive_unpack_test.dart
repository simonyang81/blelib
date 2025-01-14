// import 'dart:typed_data';

// import 'package:blelib/blelib.dart';
// import 'package:blelib/interface/ble_recv_interface.dart';

// class AppDataCallbackTest implements BleCommonRecvInterface {
//   late String onRecvGetVersion_version;
//   late int onRecvNotifyModeParam_mode;
//   late int onRecvNotifyShutdown_timeLeft;
//   late bool onRecvNotifyStart_result;
//   late bool onRecvNotifyStop_result;
//   late int onRecvNotifyStrengthParam_strength;
//   late Uint8List onRecvReadDefaultModeParam_List;
//   late Uint8List onRecvReadDeviceCode_List;
//   late int onRecvReadModeParam_mode;
//   late Uint8List onRecvReadStatus_List;
//   late int onRecvReadStrengthParam_strength;
// //late onRecvReverseKeyAuth_
//   late bool onRecvSetDefaultMode_result;
//   late bool onRecvSetDeviceCode_result;
//   late bool onRecvSetDeviceName_result;
//   late bool onRecvSetDevicePin_result;
//   late bool onRecvSetModeParam_result;
//   late bool onRecvSetStart_result;
//   late bool onRecvSetStop_result;
//   late bool onRecvSetStrengthParam_result;
//   late bool onRecvSetTimeLenParams_result;
//   late bool onRecvShutdown_result;
//   late Uint8List onRecvStartSession_List;
//   late bool onRecvSyncTime_result;

//   @override
//   void onRecvGetBatteryLevel(BleDevice bleDevice, bool result, Uint8List batteryLevel) {
//     // TODO: implement onRecvGetBatteryLevel
//   }

//   @override
//   void onRecvGetDefaultLevel(BleDevice bleDevice, bool result, Uint8List defaultLevel) {
//     // TODO: implement onRecvGetDefaultLevel
//   }

//   @override
//   void onRecvGetDefaultMode(BleDevice bleDevice, bool result, Uint8List defaultMode) {
//     // TODO: implement onRecvGetDefaultMode
//   }

//   @override
//   void onRecvGetDevStatus(BleDevice bleDevice, bool result, Uint8List devStatus) {
//     // TODO: implement onRecvGetDevStatus
//   }

//   @override
//   void onRecvGetDeviceName(BleDevice bleDevice, bool result, Uint8List deviceName) {
//     // TODO: implement onRecvGetDeviceName
//   }

//   @override
//   void onRecvGetEIKCode(BleDevice bleDevice, bool result, Uint8List eikCode) {
//     // TODO: implement onRecvGetEIKCode
//   }

//   @override
//   void onRecvGetFWVersion(BleDevice bleDevice, bool result, Uint8List version) {
//     // TODO: implement onRecvGetFWVersion
//   }

//   @override
//   void onRecvGetLevel(BleDevice bleDevice, bool result, Uint8List level) {
//     // TODO: implement onRecvGetLevel
//   }

//   @override
//   void onRecvGetMode(BleDevice bleDevice, bool result, Uint8List mode) {
//     // TODO: implement onRecvGetMode
//   }

//   @override
//   void onRecvGetTestFlag(BleDevice bleDevice, bool result, Uint8List testFlag) {
//     // TODO: implement onRecvGetTestFlag
//   }

//   @override
//   void onRecvGetTimeLen(BleDevice bleDevice, bool result, Uint8List timer) {
//     // TODO: implement onRecvGetTimeLen
//   }

//   @override
//   void onRecvNotifyBatteryLevel(BleDevice bleDevice, Uint8List batteryLevel) {
//     // TODO: implement onRecvNotifyBatteryLevel
//   }

//   @override
//   void onRecvNotifyLevel(BleDevice bleDevice, Uint8List level) {
//     // TODO: implement onRecvNotifyLevel
//   }

//   @override
//   void onRecvNotifyMode(BleDevice bleDevice, Uint8List mode) {
//     // TODO: implement onRecvNotifyMode
//   }

//   @override
//   void onRecvNotifyPause(BleDevice bleDevice) {
//     // TODO: implement onRecvNotifyPause
//   }

//   @override
//   void onRecvNotifyShutdown(BleDevice bleDevice) {
//     // TODO: implement onRecvNotifyShutdown
//   }

//   @override
//   void onRecvNotifyStart(BleDevice bleDevice) {
//     // TODO: implement onRecvNotifyStart
//   }

//   @override
//   void onRecvNotifyStop(BleDevice bleDevice) {
//     // TODO: implement onRecvNotifyStop
//   }

//   @override
//   void onRecvNotifyTimeLen(BleDevice bleDevice, Uint8List timer) {
//     // TODO: implement onRecvNotifyTimeLen
//   }

//   @override
//   void onRecvPause(BleDevice bleDevice, bool result) {
//     // TODO: implement onRecvPause
//   }

//   @override
//   void onRecvSetDefaultLevel(BleDevice bleDevice, bool result) {
//     // TODO: implement onRecvSetDefaultLevel
//   }

//   @override
//   void onRecvSetDefaultMode(BleDevice bleDevice, bool result) {
//     // TODO: implement onRecvSetDefaultMode
//   }

//   @override
//   void onRecvSetDeviceName(BleDevice bleDevice, bool result) {
//     // TODO: implement onRecvSetDeviceName
//   }

//   @override
//   void onRecvSetLevel(BleDevice bleDevice, bool result, Uint8List level) {
//     // TODO: implement onRecvSetLevel
//   }

//   @override
//   void onRecvSetMode(BleDevice bleDevice, bool result, Uint8List mode) {
//     // TODO: implement onRecvSetMode
//   }

//   @override
//   void onRecvSetTestFlag(BleDevice bleDevice, bool result) {
//     // TODO: implement onRecvSetTestFlag
//   }

//   @override
//   void onRecvSetTimeLen(BleDevice bleDevice, bool result, Uint8List timer) {
//     // TODO: implement onRecvSetTimeLen
//   }

//   @override
//   void onRecvShutdown(BleDevice bleDevice, bool result) {
//     // TODO: implement onRecvShutdown
//   }

//   @override
//   void onRecvStart(BleDevice bleDevice, bool result) {
//     // TODO: implement onRecvStart
//   }

//   @override
//   void onRecvStop(BleDevice bleDevice, bool result) {
//     // TODO: implement onRecvStop
//   }

//   @override
//   void onRecvSyncTime(BleDevice bleDevice, bool result) {
//     // TODO: implement onRecvSyncTime
//   }

//   @override
//   void onRecvBigData(BleDevice device, bool result, Uint8List data) {
//     // TODO: implement onRecvBigData
//   }

//   @override
//   void onRecvPropertyCode(BleDevice device, bool result, Uint8List eikCode) {
//     // TODO: implement onRecvPropertyCode
//   }


// }

// void main() {
//   /*
//   var mockDevice = MockBleDevice();
//   test('onRecvGetVersion', () {
//     CommonProtoReceiver commonProtoSender = CommonProtoReceiver();
//     AppDataCallbackTest appDataCallbackTest = AppDataCallbackTest();
//     commonProtoSender.setCallbackReceiver(appDataCallbackTest);
//     commonProtoSender.onRecvGetVersion(
//         mockDevice, Uint8List.fromList([0x2, 0x5, 0x6]));
//     expect(
//         appDataCallbackTest.onRecvGetVersion_version, utf8.decode([0x5, 0x6]));
//     //expectAsync0(() => mockDevice)
//   });
//   test('onRecvKeyAuth', () {});

//   test('onRecvNotifyModeParam', () {
//     CommonProtoReceiver commonProtoSender = CommonProtoReceiver();
//     AppDataCallbackTest appDataCallbackTest = AppDataCallbackTest();
//     commonProtoSender.setCallbackReceiver(appDataCallbackTest);
//     commonProtoSender.onRecvNotifyModeParam(
//         mockDevice, Uint8List.fromList([0x2]));
//     expect(appDataCallbackTest.onRecvNotifyModeParam_mode, 0x2);
//     //expectAsync0(() => mockDevice)
//   });
//   test('onRecvNotifyShutdown', () {
//     CommonProtoReceiver commonProtoSender = CommonProtoReceiver();
//     AppDataCallbackTest appDataCallbackTest = AppDataCallbackTest();
//     commonProtoSender.setCallbackReceiver(appDataCallbackTest);
//     commonProtoSender.onRecvNotifyShutdown(
//         mockDevice, Uint8List.fromList([0x3]));
//     expect(appDataCallbackTest.onRecvNotifyShutdown_timeLeft, 3);
//     //expectAsync0(() => mockDevice)
//   });
//   test('onRecvNotifyStart', () {
//     CommonProtoReceiver commonProtoSender = CommonProtoReceiver();
//     AppDataCallbackTest appDataCallbackTest = AppDataCallbackTest();
//     commonProtoSender.setCallbackReceiver(appDataCallbackTest);
//     commonProtoSender.onRecvNotifyStart(mockDevice, Uint8List.fromList([]));
//     expect(appDataCallbackTest.onRecvNotifyStart_result, true);

//     //expectAsync0(() => mockDevice)
//   });
//   test('onRecvNotifyStop', () {
//     CommonProtoReceiver commonProtoSender = CommonProtoReceiver();
//     AppDataCallbackTest appDataCallbackTest = AppDataCallbackTest();
//     commonProtoSender.setCallbackReceiver(appDataCallbackTest);
//     commonProtoSender.onRecvNotifyStop(mockDevice, Uint8List.fromList([]));
//     expect(appDataCallbackTest.onRecvNotifyStop_result, true);
//   });
//   test('onRecvNotifyStrengthParam', () {
//     CommonProtoReceiver commonProtoSender = CommonProtoReceiver();
//     AppDataCallbackTest appDataCallbackTest = AppDataCallbackTest();
//     commonProtoSender.setCallbackReceiver(appDataCallbackTest);
//     commonProtoSender.onRecvNotifyStrengthParam(
//         mockDevice, Uint8List.fromList([0x03]));
//     expect(appDataCallbackTest.onRecvNotifyStrengthParam_strength, 3);

//     //expectAsync0(() => mockDevice)
//   });
//   test('onRecvReadDefaultModeParam', () {
//     CommonProtoReceiver commonProtoSender = CommonProtoReceiver();
//     AppDataCallbackTest appDataCallbackTest = AppDataCallbackTest();
//     commonProtoSender.setCallbackReceiver(appDataCallbackTest);
//     commonProtoSender.onRecvReadDefaultModeParam(
//         mockDevice, Uint8List.fromList([0x03, 0x01, 0x05]));
//     expect(appDataCallbackTest.onRecvReadDefaultModeParam_List,
//         [0x03, 0x01, 0x05]);

//     //expectAsync0(() => mockDevice)
//   });
//   test('onRecvReadDeviceCode', () {
//     CommonProtoReceiver commonProtoSender = CommonProtoReceiver();
//     AppDataCallbackTest appDataCallbackTest = AppDataCallbackTest();
//     commonProtoSender.setCallbackReceiver(appDataCallbackTest);
//     commonProtoSender.onRecvReadDeviceCode(
//         mockDevice, Uint8List.fromList([0x04, 0x50, 0x00, 0x42]));
//     expect(appDataCallbackTest.onRecvReadDeviceCode_List,
//         [0x04, 0x50, 0x00, 0x42]);

//     //expectAsync0(() => mockDevice)
//   });

//   test('onRecvReadModeParam', () {
//     CommonProtoReceiver commonProtoSender = CommonProtoReceiver();
//     AppDataCallbackTest appDataCallbackTest = AppDataCallbackTest();
//     commonProtoSender.setCallbackReceiver(appDataCallbackTest);
//     commonProtoSender.onRecvReadModeParam(
//         mockDevice, Uint8List.fromList([0x04]));
//     expect(appDataCallbackTest.onRecvReadModeParam_mode, 4);

//     //expectAsync0(() => mockDevice)
//   });
//   test('onRecvReadStatus', () {
//     CommonProtoReceiver commonProtoSender = CommonProtoReceiver();
//     AppDataCallbackTest appDataCallbackTest = AppDataCallbackTest();
//     commonProtoSender.setCallbackReceiver(appDataCallbackTest);
//     commonProtoSender.onRecvReadStatus(mockDevice, Uint8List.fromList([0x04]));
//     expect(appDataCallbackTest.onRecvReadStatus_List, [0x04]);
//     commonProtoSender.onRecvReadStatus(
//         mockDevice, Uint8List.fromList([0x04, 0x1]));
//     expect(appDataCallbackTest.onRecvReadStatus_List, [0x04, 0x1]);
//     //expectAsync0(() => mockDevice)
//   });
//   test('onRecvReadStrengthParam', () {
//     CommonProtoReceiver commonProtoSender = CommonProtoReceiver();
//     AppDataCallbackTest appDataCallbackTest = AppDataCallbackTest();
//     commonProtoSender.setCallbackReceiver(appDataCallbackTest);
//     commonProtoSender.onRecvReadStrengthParam(
//         mockDevice, Uint8List.fromList([0x04]));
//     expect(appDataCallbackTest.onRecvReadStrengthParam_strength, 4);

//     //expectAsync0(() => mockDevice)
//   });
//   test('onRecvReverseKeyAuth', () {});
//   test('onRecvSetDefaultMode', () {
//     CommonProtoReceiver commonProtoSender = CommonProtoReceiver();
//     AppDataCallbackTest appDataCallbackTest = AppDataCallbackTest();
//     commonProtoSender.setCallbackReceiver(appDataCallbackTest);
//     commonProtoSender.onRecvSetDefaultMode(
//         mockDevice, Uint8List.fromList([0x01]));
//     expect(appDataCallbackTest.onRecvSetDefaultMode_result, true);

//     //expectAsync0(() => mockDevice)
//   });
//   test('onRecvSetDeviceCode', () {
//     CommonProtoReceiver commonProtoSender = CommonProtoReceiver();
//     AppDataCallbackTest appDataCallbackTest = AppDataCallbackTest();
//     commonProtoSender.setCallbackReceiver(appDataCallbackTest);
//     commonProtoSender.onRecvSetDeviceCode(
//         mockDevice, Uint8List.fromList([0x01]));
//     expect(appDataCallbackTest.onRecvSetDeviceCode_result, true);

//     //expectAsync0(() => mockDevice)
//   });
//   test('onRecvSetDeviceName', () {
//     CommonProtoReceiver commonProtoSender = CommonProtoReceiver();
//     AppDataCallbackTest appDataCallbackTest = AppDataCallbackTest();
//     commonProtoSender.setCallbackReceiver(appDataCallbackTest);
//     commonProtoSender.onRecvSetDeviceName(
//         mockDevice, Uint8List.fromList([0x01]));
//     expect(appDataCallbackTest.onRecvSetDeviceName_result, true);

//     //expectAsync0(() => mockDevice)
//   });
//   test('onRecvSetDevicePin', () {
//     CommonProtoReceiver commonProtoSender = CommonProtoReceiver();
//     AppDataCallbackTest appDataCallbackTest = AppDataCallbackTest();
//     commonProtoSender.setCallbackReceiver(appDataCallbackTest);
//     commonProtoSender.onRecvSetDevicePin(
//         mockDevice, Uint8List.fromList([0x01]));
//     expect(appDataCallbackTest.onRecvSetDevicePin_result, true);

//     //expectAsync0(() => mockDevice)
//   });
//   test('onRecvSetModeParam', () {
//     CommonProtoReceiver commonProtoSender = CommonProtoReceiver();
//     AppDataCallbackTest appDataCallbackTest = AppDataCallbackTest();
//     commonProtoSender.setCallbackReceiver(appDataCallbackTest);
//     commonProtoSender.onRecvSetModeParam(
//         mockDevice, Uint8List.fromList([0x01]));
//     expect(appDataCallbackTest.onRecvSetModeParam_result, true);

//     //expectAsync0(() => mockDevice)
//   });
//   test('onRecvSetStart', () {
//     CommonProtoReceiver commonProtoSender = CommonProtoReceiver();
//     AppDataCallbackTest appDataCallbackTest = AppDataCallbackTest();
//     commonProtoSender.setCallbackReceiver(appDataCallbackTest);
//     commonProtoSender.onRecvSetStart(mockDevice, Uint8List.fromList([0x01]));
//     expect(appDataCallbackTest.onRecvSetStart_result, true);

//     //expectAsync0(() => mockDevice)
//   });
//   test('onRecvSetStop', () {
//     CommonProtoReceiver commonProtoSender = CommonProtoReceiver();
//     AppDataCallbackTest appDataCallbackTest = AppDataCallbackTest();
//     commonProtoSender.setCallbackReceiver(appDataCallbackTest);
//     commonProtoSender.onRecvSetStop(mockDevice, Uint8List.fromList([0x01]));
//     expect(appDataCallbackTest.onRecvSetStop_result, true);

//     //expectAsync0(() => mockDevice)
//   });
//   test('onRecvSetStrengthParam', () {
//     CommonProtoReceiver commonProtoSender = CommonProtoReceiver();
//     AppDataCallbackTest appDataCallbackTest = AppDataCallbackTest();
//     commonProtoSender.setCallbackReceiver(appDataCallbackTest);
//     commonProtoSender.onRecvSetStrengthParam(
//         mockDevice, Uint8List.fromList([0x01]));
//     expect(appDataCallbackTest.onRecvSetStrengthParam_result, true);

//     //expectAsync0(() => mockDevice)
//   });
//   test('onRecvSetTimeLenParams', () {
//     CommonProtoReceiver commonProtoSender = CommonProtoReceiver();
//     AppDataCallbackTest appDataCallbackTest = AppDataCallbackTest();
//     commonProtoSender.setCallbackReceiver(appDataCallbackTest);
//     commonProtoSender.onRecvSetTimeLenParams(
//         mockDevice, Uint8List.fromList([0x01]));
//     expect(appDataCallbackTest.onRecvSetTimeLenParams_result, true);

//     //expectAsync0(() => mockDevice)
//   });
//   test('onRecvShutdown', () {
//     CommonProtoReceiver commonProtoSender = CommonProtoReceiver();
//     AppDataCallbackTest appDataCallbackTest = AppDataCallbackTest();
//     commonProtoSender.setCallbackReceiver(appDataCallbackTest);
//     commonProtoSender.onRecvShutdown(mockDevice, Uint8List.fromList([0x01]));
//     expect(appDataCallbackTest.onRecvShutdown_result, true);

//     //expectAsync0(() => mockDevice)
//   });
//   test('onRecvStartSession', () {});
//   test('onRecvSyncTime', () {
//     CommonProtoReceiver commonProtoSender = CommonProtoReceiver();
//     AppDataCallbackTest appDataCallbackTest = AppDataCallbackTest();
//     commonProtoSender.setCallbackReceiver(appDataCallbackTest);
//     commonProtoSender.onRecvSyncTime(mockDevice, Uint8List.fromList([0x01]));
//     expect(appDataCallbackTest.onRecvSyncTime_result, true);

//     //expectAsync0(() => mockDevice)
//   });
//   */
// }
