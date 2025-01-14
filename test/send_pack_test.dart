// import 'package:blelib/ble/common_proto_content_packer.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter_test/flutter_test.dart';

// void main() {
//   test('packStartSession', () {
//     CommonProtoContentPacker dataPacker = CommonProtoContentPacker();
//     expect(dataPacker.packStartSession(20231120),
//         Uint8List.fromList([0x01, 0x34, 0xB3, 0xD0]));
//     //expectAsync0(() => null)
//   });
//   test('packReadStatus', () {
//     CommonProtoContentPacker dataPacker = CommonProtoContentPacker();
//     expect(dataPacker.packReadStatus(), Uint8List.fromList([]));
//     //expectAsync0(() => null)
//   });
//   test('packSetDeviceName', () {
//     CommonProtoContentPacker dataPacker = CommonProtoContentPacker();
//     expect(dataPacker.packSetDeviceName('abc'),
//         Uint8List.fromList([3, 0x61, 0x62, 0x63]));
//     //expectAsync0(() => null)
//   });
//   test('packSetDevicePin', () {
//     CommonProtoContentPacker dataPacker = CommonProtoContentPacker();
//     expect(dataPacker.packSetDevicePin('abc'),
//         Uint8List.fromList([3, 0x61, 0x62, 0x63]));
//     //expectAsync0(() => null)
//   });
//   test('packKeyAuth', () {
//     CommonProtoContentPacker dataPacker = CommonProtoContentPacker();
//     expect(dataPacker.packKeyAuth(Uint8List.fromList([0, 1])),
//         Uint8List.fromList([0, 2, 0, 1]));
//     //expectAsync0(() => null)
//   });

//   test('packGetVersion', () {
//     CommonProtoContentPacker dataPacker = CommonProtoContentPacker();
//     expect(dataPacker.packGetVersion(), Uint8List.fromList([]));
//     //expectAsync0(() => null)
//   });
//   test('packSyncTime', () {
//     CommonProtoContentPacker dataPacker = CommonProtoContentPacker();
//     expect(dataPacker.packSyncTime(2023, 11, 17, 17, 26, 30),
//         Uint8List.fromList([0x07, 0xE7, 11, 17, 17, 26, 30]));
//     //expectAsync0(() => null)
//   });
//   test('packReadDeviceCode', () {
//     CommonProtoContentPacker dataPacker = CommonProtoContentPacker();
//     expect(dataPacker.packReadEikCode(), Uint8List.fromList([]));
//     //expectAsync0(() => null)
//   });
//   test('packSetMode', () {
//     CommonProtoContentPacker dataPacker = CommonProtoContentPacker();
//     expect(dataPacker.packSetMode(1), Uint8List.fromList([1]));
//     //expectAsync0(() => null)
//   });
//   test('packSetLevel', () {
//     CommonProtoContentPacker dataPacker = CommonProtoContentPacker();
//     expect(dataPacker.packSetLevel(2), Uint8List.fromList([2]));
//     //expectAsync0(() => null)
//   });
//   test('packSetTimeLen', () {
//     CommonProtoContentPacker dataPacker = CommonProtoContentPacker();
//     expect(dataPacker.packSetTimeLen(3), Uint8List.fromList([3]));
//     //expectAsync0(() => null)
//   });
//   test('packNotifyMode', () {
//     CommonProtoContentPacker dataPacker = CommonProtoContentPacker();
//     expect(dataPacker.packNotifyMode(1), Uint8List.fromList([1]));
//     //expectAsync0(() => null)
//   });
//   test('packNotifyLevel', () {
//     CommonProtoContentPacker dataPacker = CommonProtoContentPacker();
//     expect(dataPacker.packNotifyLevel(1), Uint8List.fromList([1]));
//     //expectAsync0(() => null)
//   });
//   test('packReadMode', () {
//     CommonProtoContentPacker dataPacker = CommonProtoContentPacker();
//     expect(dataPacker.packReadMode(), Uint8List.fromList([]));
//     //expectAsync0(() => null)
//   });
//   test('packReadStrength', () {
//     CommonProtoContentPacker dataPacker = CommonProtoContentPacker();
//     expect(dataPacker.packReadStrength(), Uint8List.fromList([]));
//     //expectAsync0(() => null)
//   });
//   test('packSetStart', () {
//     CommonProtoContentPacker dataPacker = CommonProtoContentPacker();
//     expect(dataPacker.packSetStart(), Uint8List.fromList([]));
//     //expectAsync0(() => null)
//   });
//   test('packSetStop', () {
//     CommonProtoContentPacker dataPacker = CommonProtoContentPacker();
//     expect(dataPacker.packSetStop(), Uint8List.fromList([]));
//     //expectAsync0(() => null)
//   });
//   test('packNotifyStart', () {
//     CommonProtoContentPacker dataPacker = CommonProtoContentPacker();
//     expect(dataPacker.packNotifyStart(1), Uint8List.fromList([1]));
//     //expectAsync0(() => null)
//   });
//   test('packNotifyStop', () {
//     CommonProtoContentPacker dataPacker = CommonProtoContentPacker();
//     expect(dataPacker.packNotifyStop(1), Uint8List.fromList([1]));
//     //expectAsync0(() => null)
//   });
//   test('packSetDefaultMode', () {
//     CommonProtoContentPacker dataPacker = CommonProtoContentPacker();
//     expect(
//         dataPacker.packSetDefaultMode(1, 2, 3), Uint8List.fromList([1, 2, 3]));
//     //expectAsync0(() => null)
//   });
//   test('packReadDefaultMode', () {
//     CommonProtoContentPacker dataPacker = CommonProtoContentPacker();
//     expect(dataPacker.packReadDefaultMode(), Uint8List.fromList([]));
//     //expectAsync0(() => null)
//   });
//   test('packShutdown', () {
//     CommonProtoContentPacker dataPacker = CommonProtoContentPacker();
//     expect(dataPacker.packShutdown(), Uint8List.fromList([]));
//     //expectAsync0(() => null)
//   });
//   test('packNotifyShutdown', () {
//     CommonProtoContentPacker dataPacker = CommonProtoContentPacker();
//     expect(dataPacker.packNotifyShutdown(1), Uint8List.fromList([1]));
//     //expectAsync0(() => null)
//   });
//   // test('packSetDeviceCode', () {
//   //   CommonProtoContentPacker dataPacker = CommonProtoContentPacker();
//   //   expect(
//   //       dataPacker.packSetDeviceCode(0, 2, 0x1110008000, 0x08100080),
//   //       Uint8List.fromList(
//   //           [0, 0, 2, 0, 0x11, 0x10, 00, 0x80, 0, 0x08, 0x10, 0, 0x80]));
//   //   //expectAsync0(() => null)
//   // });
//   test('packNotifyBattery', () {
//     CommonProtoContentPacker dataPacker = CommonProtoContentPacker();
//     expect(dataPacker.packNotifyShutdown(1), Uint8List.fromList([1]));
//   });
//   test('packSetPause', () {
//     CommonProtoContentPacker dataPacker = CommonProtoContentPacker();
//     expect(dataPacker.packSetPause(), Uint8List.fromList([]));
//   });
//   test('packNotifyPause', () {
//     CommonProtoContentPacker dataPacker = CommonProtoContentPacker();
//     expect(dataPacker.packNotifyPause(1), Uint8List.fromList([1]));
//   });
//   test('packNotifyTimeLen', () {
//     CommonProtoContentPacker dataPacker = CommonProtoContentPacker();
//     expect(dataPacker.packNotifyTimeLen(1), Uint8List.fromList([1]));
//   });
//   test('packReadTimeLen', () {
//     CommonProtoContentPacker dataPacker = CommonProtoContentPacker();
//     expect(dataPacker.packReadTimeLen(), Uint8List.fromList([]));
//   });
//   test('packReadBattery', () {
//     CommonProtoContentPacker dataPacker = CommonProtoContentPacker();
//     expect(dataPacker.packReadBattery(), Uint8List.fromList([]));
//   });
//   test('packSetDefaultLevel', () {
//     CommonProtoContentPacker dataPacker = CommonProtoContentPacker();
//     expect(dataPacker.packSetDefaultLevel(1), Uint8List.fromList([1]));
//   });
//   test('packReadDefaultLevel', () {
//     CommonProtoContentPacker dataPacker = CommonProtoContentPacker();
//     expect(dataPacker.packReadDefaultLevel(), Uint8List.fromList([]));
//   });
//   test('packSetTestFlag', () {
//     CommonProtoContentPacker dataPacker = CommonProtoContentPacker();
//     expect(dataPacker.packSetTestFlag(1), Uint8List.fromList([1]));
//   });
//   test('packReadTestFlag', () {
//     CommonProtoContentPacker dataPacker = CommonProtoContentPacker();
//     expect(dataPacker.packReadTestFlag(), Uint8List.fromList([]));
//   });
// }
