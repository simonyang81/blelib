import 'package:blelib/ble/ble_format.dart';
import 'package:blelib/ble/product_config.dart';
import 'package:blelib/blelib.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Config.isUnitTest = true;

  test("packBLEMessage", () {
    var productConfig1 = ProductConfig(
        'name',
        'vtwhc3jovyzvd400',
        'serviceUuid',
        'characterUuid',
        'characterUuid',
        "ABC-",
        '0000af30-0000-1000-8000-00805f9b34fb');
    var productConfig2 = ProductConfig(
        'name',
        'vtwhc3jovyzvd4h4',
        'serviceUuid',
        'characterUuid',
        'characterUuid',
        "EIK-",
        '00001001-0000-1000-8000-00805f9b34fb');

    Config.configList.clear();
    Config.addProductConfig(productConfig1);
    Config.addProductConfig(productConfig2);

    BleDevice bleDevice = BleDevice.fromId("xxxxxx", "EIK-AAAAA");
    bleDevice.productConfig = productConfig2;

    var packs =
        packBLEMessage(Uint8List.fromList([1, 2, 3, 4, 5, 6, 7, 8]), bleDevice);
    expect(
        packs[0],
        Uint8List.fromList([
          0xEB,
          0x35,
          0x13,
          0x6B,
          0xEB,
          0xA1,
          0xC3,
          0x86,
          0x60,
          0x21,
          0x60,
          0x80,
          0x3F,
          0xB9,
          0x35,
          0xE7
        ]));
  });

  test("packBLEMessage", () {
    var productConfig1 = ProductConfig(
        'name',
        'vtwhc3jovyzvd400',
        'serviceUuid',
        'characterUuid',
        'characterUuid',
        "ABC-",
        '0000af30-0000-1000-8000-00805f9b34fb');
    var productConfig2 = ProductConfig(
        'name',
        'vtwhc3jovyzvd4h4',
        'serviceUuid',
        'characterUuid',
        'characterUuid',
        "EIK-",
        '00001001-0000-1000-8000-00805f9b34fb');

    Config.configList.clear();
    Config.addProductConfig(productConfig1);
    Config.addProductConfig(productConfig2);

    BleDevice bleDevice = BleDevice.fromId("xxxxxx", "AAAAA");
    bleDevice.productConfig = productConfig2;

    var packs =
        packBLEMessage(Uint8List.fromList([1, 2, 3, 4, 5, 6, 7, 8]), bleDevice);
    expect(
        packs[0],
        Uint8List.fromList([
          0xEB,
          0x35,
          0x13,
          0x6B,
          0xEB,
          0xA1,
          0xC3,
          0x86,
          0x60,
          0x21,
          0x60,
          0x80,
          0x3F,
          0xB9,
          0x35,
          0xE7
        ]));
  });

  test("ByteData setUint16 endian", () {
    ByteData d = ByteData(2);
    d.setUint16(0, 0x0102);
    expect(0x01, d.getUint8(0));
    expect(0x02, d.getUint8(1));
  });
}
