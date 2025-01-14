// import 'dart:typed_data';

// import 'package:blelib/ble/kernel/tool.dart';
// import 'package:blelib/ble/product_config.dart';
// import 'package:blelib/ble/util.dart';
// import 'package:flutter_blue_plus/flutter_blue_plus.dart';
// import 'package:flutter_test/flutter_test.dart';

// import 'package:blelib/blelib.dart';
// import 'package:get/get.dart';

// import 'receive_test.mocks.dart';

// void main() {
//   setUpAll(() async {
//     WorkingDevice workingDevice = Get.put(WorkingDevice());
//     await workingDevice.onInit();
//   });

//   test('getPrefixIndex', () {
//     ProductConfig productConfig1 = ProductConfig('name', 'aesKey',
//         'serviceUuid', 'characterUuid', 'notifycharacterUuid', "ABC_");
//     ProductConfig productConfig2 = ProductConfig('name', 'aesKey',
//         'serviceUuid', 'characterUuid', 'notifycharacterUuid', "DEF_");
//     ProductConfig productConfig3 = ProductConfig('name', 'aesKey',
//         'serviceUuid', 'characterUuid', 'notifycharacterUuid', "GHI_");
//     Config.addProductConfig(productConfig1);
//     Config.addProductConfig(productConfig2);
//     Config.addProductConfig(productConfig3);
//     expect(1, "DEF_XXXXX".getPrefixIndex(Config.getAllPrefix()));
//   });

//   test("xor", () {
//     Uint8List a = Uint8List.fromList([0x11, 0x22, 0x33, 0x44]);
//     Uint8List b = Uint8List.fromList([0x12, 0x23, 0x34, 0x45]);
//     var c = doXor(a, b, 4);
//     expect(c, [3, 1, 7, 1]);
//   });

//   test('sortByRSSI', () {
//     ScanModel scanModel = Get.put(ScanModel());
//     BleDevice d1 = BleDevice.fromId('1', '1');
//     d1.rssi = 1;
//     BleDevice d2 = BleDevice.fromId('2', '2');
//     d2.rssi = 2;
//     BleDevice d3 = BleDevice.fromId('3', '3');
//     d3.rssi = 3;

//     scanModel.scanList.add(d1);
//     scanModel.scanList.add(d2);
//     scanModel.scanList.add(d3);
//     expect(3, scanModel.count());
//     expect(1, scanModel.scanList[0].rssi);
//     expect(2, scanModel.scanList[1].rssi);
//     expect(3, scanModel.scanList[2].rssi);
//     scanModel.sortByRSSI();
//     expect(3, scanModel.scanList[0].rssi);
//     expect(2, scanModel.scanList[1].rssi);
//     expect(1, scanModel.scanList[2].rssi);
//   });

//   test("filterDefaultUuidPrefix", () {
//     String advUuid = '0000af30-0000-1000-8000-00805f9b34fb';

//     String deviceName = "ABC_XXXXX";

//     ProductConfig productConfig1 = ProductConfig('name', 'aesKey',
//         'serviceUuid', 'characterUuid', 'characterUuid', "ABC_");
//     ProductConfig productConfig2 = ProductConfig('name', 'aesKey',
//         'serviceUuid', 'characterUuid', 'characterUuid', "DEF_");
//     ProductConfig productConfig3 = ProductConfig('name', 'aesKey',
//         'serviceUuid', 'characterUuid', 'characterUuid', "GHI_");
//     Config.configList.clear();
//     Config.addProductConfig(productConfig1);
//     Config.addProductConfig(productConfig2);
//     Config.addProductConfig(productConfig3);
//     expect(
//         productConfig1,
//         BleScanner.instance.filterPrefix(
//             Config.configList, Config.getAllPrefix(), deviceName));

//     advUuid = '0000af30-0000-1000-8000-00805f9b34fb';

//     deviceName = "AB-XXXXX";
//     productConfig1 = ProductConfig('name', 'aesKey', 'serviceUuid',
//         'characterUuid', 'characterUuid', "ABC_");
//     productConfig2 = ProductConfig('name', 'aesKey', 'serviceUuid',
//         'characterUuid', 'characterUuid', "DEF_");
//     productConfig3 = ProductConfig('name', 'aesKey', 'serviceUuid',
//         'characterUuid', 'characterUuid', "GHI_");
//     Config.configList.clear();
//     Config.addProductConfig(productConfig1);
//     Config.addProductConfig(productConfig2);
//     Config.addProductConfig(productConfig3);
//     expect(
//         null,
//         BleScanner.instance.filterPrefix(
//             Config.configList, Config.getAllPrefix(), deviceName));
//   });

//   test('scan compatible mode', () {
//     var productConfig1 = ProductConfig(
//         'name',
//         'aesKey',
//         'serviceUuid',
//         'characterUuid',
//         'characterUuid',
//         "ABC_",
//         '00000005-0000-1000-8000-00805f9b34fb');
//     Config.configList.clear();
//     Config.addProductConfig(productConfig1);

//     //var blueToothDevice = BluetoothDevice.fromId('xxxx', name: 'ABC_device');
//     //var device = BleDevice(blueToothDevice);

//     ProductConfig? productConfig = BleScanner.instance
//         .filterDevice([Guid(Config.defaultScanFilterUuid)], 'ABC_device');
//     expect(productConfig, productConfig1);
//     ProductConfig? productConfig2 = BleScanner.instance.filterDevice(
//         [Guid('00000005-0000-1000-8000-00805f9b34fb')], 'ABC_device');
//     expect(productConfig, productConfig2);
//   });

//   test("filterScanWithUuid", () {
//     bool bOpenFilterByUuid = false;
//     String advUuid = '';
//     List<String> filterUuids = [];

//     expect(
//         null,
//         BleScanner.instance
//             .filterScanWithUuid(Config.configList, advUuid, filterUuids));

//     var productConfig1 = ProductConfig(
//         'name',
//         'aesKey',
//         'serviceUuid',
//         'characterUuid',
//         'characterUuid',
//         "ABC_",
//         '00000000-0000-1000-8000-00805f9b34fb');
//     var productConfig2 = ProductConfig(
//         'name',
//         'aesKey',
//         'serviceUuid',
//         'characterUuid',
//         'characterUuid',
//         "DEF_",
//         '00000002-0000-1000-8000-00805f9b34fb');
//     var productConfig3 = ProductConfig(
//         'name',
//         'aesKey',
//         'serviceUuid',
//         'characterUuid',
//         'characterUuid',
//         "GHI_",
//         '00000003-0000-1000-8000-00805f9b34fb');
//     Config.configList.clear();
//     Config.addProductConfig(productConfig1);
//     Config.addProductConfig(productConfig2);
//     Config.addProductConfig(productConfig3);
//     advUuid = '00000002-0000-1000-8000-00805f9b34fb';
//     expect(
//         productConfig2,
//         BleScanner.instance.filterScanWithUuid(
//             Config.configList, advUuid, Config.getAllScanFilterUuids()));
//     advUuid = '00000003-0000-1000-8000-00805f9b34fb';
//     expect(
//         productConfig3,
//         BleScanner.instance.filterScanWithUuid(
//             Config.configList, advUuid, Config.getAllScanFilterUuids()));

//     advUuid = '00000009-0000-1000-8000-00805f9b34fb';

//     expect(
//         null,
//         BleScanner.instance.filterScanWithUuid(
//             Config.configList, advUuid, Config.getAllScanFilterUuids()));
//   });

//   test("appendAdvUuidForIos", () {
//     String advUuid = "aaaa";
//     expect('0000$advUuid-0000-1000-8000-00805f9b34fb',
//         appendAdvUuidForIos(advUuid));
//     advUuid = 'aaaaa';
//     expect(advUuid, appendAdvUuidForIos(advUuid));
//     advUuid = '12345678';
//     expect(
//         '$advUuid-0000-1000-8000-00805f9b34fb', appendAdvUuidForIos(advUuid));
//     advUuid = '00000001-0000-1000-8000-00805f9b34fb';
//     expect(advUuid, appendAdvUuidForIos(advUuid));
//   });
// }
