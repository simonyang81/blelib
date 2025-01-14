// import 'dart:typed_data';

// import 'package:blelib/ble/ble_packet.dart';
// import 'package:blelib/ble/ble_packet_encrypt.dart';
// import 'package:blelib/ble/ble_packet_plain.dart';
// import 'package:blelib/ble/crypto.dart';
// import 'package:blelib/ble/product_config.dart';
// import 'package:blelib/blelib.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:get/get.dart';

import 'package:blelib/ble/ble_packet.dart';
import 'package:blelib/ble/ble_packet_encrypt.dart';
import 'package:blelib/ble/product_config.dart';
import 'package:blelib/blelib.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('getPackCount', () {
    Config.gUseChecksum = false;

    expect(BlePacketEncrypt.getPackCount(16, 10), 1);
    expect(BlePacketEncrypt.getPackCount(16, 13), 1);
    expect(BlePacketEncrypt.getPackCount(16, 14), 2);
    expect(BlePacketEncrypt.getPackCount(16, 15), 2);
    expect(BlePacketEncrypt.getPackCount(16, 25), 2);
    expect(BlePacketEncrypt.getPackCount(16, 26), 2);
    expect(BlePacketEncrypt.getPackCount(16, 27), 3);
    expect(BlePacketEncrypt.getPackCount(16, 28), 3);

    Config.gUseChecksum = true;

    expect(BlePacketEncrypt.getPackCount(16, 10), 1);
    expect(BlePacketEncrypt.getPackCount(16, 12), 1);
    expect(BlePacketEncrypt.getPackCount(16, 13), 2);
    expect(BlePacketEncrypt.getPackCount(16, 14), 2);
    expect(BlePacketEncrypt.getPackCount(16, 22), 2);
    expect(BlePacketEncrypt.getPackCount(16, 23), 2);
    expect(BlePacketEncrypt.getPackCount(16, 24), 2);
    expect(BlePacketEncrypt.getPackCount(16, 25), 3);
  });

  test('appendChecksum', () {
    Uint8List? content;
    var contentChksum = BlePacket.appendChecksum(content);
    expect(contentChksum, Uint8List.fromList([0]));
    content = Uint8List.fromList([1, 2, 3]);
    contentChksum = BlePacket.appendChecksum(content);
    expect(contentChksum, Uint8List.fromList([1, 2, 3, 6]));
  });

  test("packWithoutEncrypt without checksum", () {
    Config.gMtu = 20;
    Config.gUseAesEncrypt = false;
    Config.gUseChecksum = false;
    Uint8List? content;

    var pack1 = BlePacket.pack(null, 0xffee, content);
    expect(pack1, [
      Uint8List.fromList(
          [0xa4, 5 | (BlePacket.protocolVersion << 4), 0, 6, 0xff, 0xee])
    ]);

    Uint8List? content1 = Uint8List.fromList([]);
    var pack2 = BlePacket.pack(null, 0xffee, content1);
    expect(pack2, [
      Uint8List.fromList(
          [0xa4, 5 | (BlePacket.protocolVersion << 4), 0, 6, 0xff, 0xee])
    ]);

    Uint8List? content3 =
        Uint8List.fromList([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15]);
    var pack3 = BlePacket.pack(null, 0xffee, content3);
    expect(
      pack3,
      [
        Uint8List.fromList(
          [
            0xa4,
            4 | (BlePacket.protocolVersion << 4),
            0,
            20,
            0xff,
            0xee,
            1,
            2,
            3,
            4,
            5,
            6,
            7,
            8,
            9,
            10,
            11,
            12,
            13,
            14
          ],
        ),
        Uint8List.fromList(
            [0xa4, 1 | (BlePacket.protocolVersion << 4), 0, 7, 0xff, 0xee, 15])
      ],
    );
  });

  test("packWithoutEncrypt with checksum", () {
    Config.gMtu = 20;
    Config.gUseAesEncrypt = false;
    Config.gUseChecksum = true;
    Uint8List? content;

    var pack1 = BlePacket.pack(null, 0xffee, content);
    expect(pack1, [
      Uint8List.fromList([
        0xa4,
        5 | (BlePacket.protocolVersion << 4) | (1 << 3),
        0,
        7,
        0xff,
        0xee,
        0xed
      ])
    ]);

    Uint8List? content1 = Uint8List.fromList([]);
    var pack2 = BlePacket.pack(null, 0xffee, content1);
    expect(pack2, [
      Uint8List.fromList([
        0xa4,
        5 | (BlePacket.protocolVersion << 4) | (1 << 3),
        0,
        7,
        0xff,
        0xee,
        0xed
      ])
    ]);

    Uint8List? content3 =
        Uint8List.fromList([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15]);
    var pack3 = BlePacket.pack(null, 0xffee, content3);
    expect(
      pack3,
      [
        Uint8List.fromList(
          [
            0xa4,
            4 | (BlePacket.protocolVersion << 4) | (1 << 3),
            0,
            20,
            0xff,
            0xee,
            1,
            2,
            3,
            4,
            5,
            6,
            7,
            8,
            9,
            10,
            11,
            12,
            13,
            0x48
          ],
        ),
        Uint8List.fromList([
          0xa4,
          1 | (BlePacket.protocolVersion << 4) | (1 << 3),
          0,
          9,
          0xff,
          0xee,
          14,
          15,
          0xa
        ])
      ],
    );
  });

  test("packWithEncrypt 1 without checksum", () {
    Config.gMtu = 20;
    int cmdOrder = 0xffee;
    ProductConfig productConfig = ProductConfig(
        'name', 'vtwhc3jovyzvd4h4', 'serviceUuid', 'characterUuid', 'ABC_');

    Config.gUseAesEncrypt = true;
    Config.gUseChecksum = false;
    Uint8List? content;
    var packs = BlePacket.pack(productConfig.aesKey, cmdOrder, content);
    expect(packs.length, 1);
    expect(
        packs[0],
        Uint8List.fromList([
          0xA5,
          5 | (BlePacket.protocolVersion << 4),
          0,
          0x14,
          0xFC,
          0x78,
          0xFC,
          0x5D,
          0xF0,
          0xA9,
          0x23,
          0x02,
          0x3D,
          0xB7,
          0xF9,
          0x30,
          0x23,
          0x2F,
          0x79,
          0x6E
        ]));
  });

  test("packWithEncrypt 2 without checksum", () {
    Config.gMtu = 20;
    int cmdOrder = 0xffee;
    ProductConfig productConfig = ProductConfig(
        'name', 'vtwhc3jovyzvd4h4', 'serviceUuid', 'characterUuid', 'ABC_');

    Config.gUseAesEncrypt = true;
    Config.gUseChecksum = false;
    var content = Uint8List.fromList([1, 2, 3, 4, 5, 6]);

    var packs = BlePacket.pack(productConfig.aesKey, cmdOrder, content);
    expect(packs.length, 1);
    expect(
        packs[0],
        Uint8List.fromList([
          0xA5,
          5 | (BlePacket.protocolVersion << 4),
          0,
          0x14,
          0xDA,
          0x21,
          0x35,
          0x28,
          0x52,
          0xFF,
          0x19,
          0x8C,
          0x3D,
          0x30,
          0x36,
          0x39,
          0xC6,
          0x9E,
          0x80,
          0x27
        ]));
  });

  test("packWithEncrypt 3 without checksum", () {
    Config.gMtu = 20;
    int cmdOrder = 0xffee;
    ProductConfig productConfig = ProductConfig(
        'name', 'vtwhc3jovyzvd4h4', 'serviceUuid', 'characterUuid', 'ABC_');

    Config.gUseAesEncrypt = true;
    Config.gUseChecksum = false;
    var content =
        Uint8List.fromList([1, 2, 3, 4, 5, 6, 7, 8, 9, 0xa, 0xb, 0xc, 0xd]);

    var packs = BlePacket.pack(productConfig.aesKey, cmdOrder, content);
    expect(packs.length, 1);
    expect(
        packs[0],
        Uint8List.fromList([
          0xa5,
          5 | (BlePacket.protocolVersion << 4),
          0,
          0x14,
          0x44,
          0x52,
          0x3F,
          0x96,
          0x4D,
          0xD6,
          0x92,
          0x58,
          0xE7,
          0xB3,
          0xD2,
          0x9A,
          0x0C,
          0xF7,
          0x51,
          0x8D
        ]));
  });

  test("packWithEncrypt 4 without checksum with long data", () {
    Config.gMtu = 20;
    int cmdOrder = 0xffee;
    ProductConfig productConfig = ProductConfig(
        'name', 'vtwhc3jovyzvd4h4', 'serviceUuid', 'characterUuid', 'ABC_');

    Config.gUseAesEncrypt = true;
    Config.gUseChecksum = false;
    var content = Uint8List.fromList(
        [1, 2, 3, 4, 5, 6, 7, 8, 9, 0xa, 0xb, 0xc, 0xd, 0xe]);

    var packs = BlePacket.pack(productConfig.aesKey, cmdOrder, content);
    expect(packs.length, 2);

    packs = BlePacket.pack(productConfig.aesKey, cmdOrder, content);

    expect(
        packs[0],
        Uint8List.fromList([
          0xa5,
          4 | (BlePacket.protocolVersion << 4),
          0,
          0x14,
          0x44,
          0x52,
          0x3F,
          0x96,
          0x4D,
          0xD6,
          0x92,
          0x58,
          0xE7,
          0xB3,
          0xD2,
          0x9A,
          0x0C,
          0xF7,
          0x51,
          0x8D
        ]));
    expect(
        packs[1],
        Uint8List.fromList([
          0xa5,
          1 | (BlePacket.protocolVersion << 4),
          0,
          0x14,
          0xDD,
          0x4B,
          0x9F,
          0x44,
          0x5E,
          0xB0,
          0x2F,
          0x2C,
          0x0E,
          0x7B,
          0xB1,
          0x2C,
          0x3F,
          0xE8,
          0x04,
          0x4B
        ]));
  });

  test("packWithEncrypt 1 with checksum with null data", () {
    Config.gMtu = 20;
    int cmdOrder = 0xffee;
    ProductConfig productConfig = ProductConfig(
        'name', 'vtwhc3jovyzvd4h4', 'serviceUuid', 'characterUuid', 'ABC_');

    Config.gUseAesEncrypt = true;
    Config.gUseChecksum = true;
    Uint8List? content;
    var packs = BlePacket.pack(productConfig.aesKey, cmdOrder, content);
    expect(packs.length, 1);
    expect(
        packs[0],
        Uint8List.fromList([
          0xA5,
          5 | (BlePacket.protocolVersion << 4) | (1 << 3),
          0,
          0x14,
          0xBC,
          0xCE,
          0x52,
          0xBF,
          0xCC,
          0xBB,
          0x17,
          0x5F,
          0x93,
          0x15,
          0x4A,
          0x5B,
          0x47,
          0xDC,
          0x0F,
          0xB5
        ]));
  });

  test("packWithEncrypt 2 with checksum with short data", () {
    Config.gMtu = 20;
    int cmdOrder = 0xffee;
    ProductConfig productConfig = ProductConfig(
        'name', 'vtwhc3jovyzvd4h4', 'serviceUuid', 'characterUuid', 'ABC_');

    Config.gUseAesEncrypt = true;
    Config.gUseChecksum = true;
    var content = Uint8List.fromList([1, 2, 3, 4, 5, 6]);

    var packs = BlePacket.pack(productConfig.aesKey, cmdOrder, content);
    expect(packs.length, 1);
    expect(
        packs[0],
        Uint8List.fromList([
          0xA5,
          0x5 | (1 << 4) | (1 << 3),
          0,
          0x14,
          0x2B,
          0x0C,
          0x6B,
          0x08,
          0x5C,
          0x8B,
          0xB3,
          0x39,
          0x50,
          0xE5,
          0x04,
          0xEF,
          0x28,
          0x36,
          0xB8,
          0x5A
        ]));
  });

  test("packWithEncrypt 2 with checksum with long data", () {
    Config.gMtu = 20;
    int cmdOrder = 0xffee;
    ProductConfig productConfig = ProductConfig(
        'name', 'vtwhc3jovyzvd4h4', 'serviceUuid', 'characterUuid', 'ABC_');

    Config.gUseAesEncrypt = true;
    Config.gUseChecksum = true;
    var content = Uint8List.fromList([
      1,
      2,
      3,
      4,
      5,
      6,
      7,
      8,
      9,
      0xa,
      0xb,
      0xc,
      0xd,
      0xe,
      0xf,
      0x10,
      0x11,
      0x12
    ]);

    var packs = BlePacket.pack(productConfig.aesKey, cmdOrder, content);
    expect(packs.length, 2);
    expect(
        packs[0],
        Uint8List.fromList([
          0xA5,
          0x4 | (1 << 4) | (1 << 3),
          0,
          20,
          0x53,
          0x9D,
          0x0C,
          0xCE,
          0xFA,
          0x20,
          0xCD,
          0x35,
          0x7E,
          0x3B,
          0x0E,
          0x78,
          0x49,
          0x4B,
          0x5E,
          0xC0
        ]));

    expect(
        packs[1],
        Uint8List.fromList([
          0xA5,
          0x1 | (1 << 4) | (1 << 3),
          0,
          20,
          0xCE,
          0x9B,
          0x32,
          0xD5,
          0xD3,
          0xAC,
          0x7A,
          0x02,
          0xC6,
          0x25,
          0x80,
          0xCC,
          0x16,
          0xAF,
          0xF5,
          0xD4
        ]));
  });
/////////////////////////////
//   test("packWithEncrypt 3 with checksum", () {
//     Config.gMtu = 20;
//     int cmdOrder = 0xffee;
//     ProductConfig productConfig = ProductConfig(
//         'name', 'vtwhc3jovyzvd4h4', 'serviceUuid', 'characterUuid', 'ABC_');

//     Config.gUseAesEncrypt = true;
//     Config.gUseChecksum = true;
//     var content =
//         Uint8List.fromList([1, 2, 3, 4, 5, 6, 7, 8, 9, 0xa, 0xb, 0xc, 0xd]);

//     var packs = BlePacket.pack(productConfig.aesKey, cmdOrder, content);
//     expect(packs.length, 1);
//     expect(
//         packs[0],
//         Uint8List.fromList([
//           0xa5,
//           5 | (BlePacket.protocolVersion << 4),
//           0,
//           0x14,
//           0x44,
//           0x52,
//           0x3F,
//           0x96,
//           0x4D,
//           0xD6,
//           0x92,
//           0x58,
//           0xE7,
//           0xB3,
//           0xD2,
//           0x9A,
//           0x0C,
//           0xF7,
//           0x51,
//           0x8D
//         ]));
//   });

//   test("packWithEncrypt 4 with checksum", () {
//     Config.gMtu = 20;
//     int cmdOrder = 0xffee;
//     ProductConfig productConfig = ProductConfig(
//         'name', 'vtwhc3jovyzvd4h4', 'serviceUuid', 'characterUuid', 'ABC_');

//     Config.gUseAesEncrypt = true;
//     Config.gUseChecksum = true;
//     var content = Uint8List.fromList(
//         [1, 2, 3, 4, 5, 6, 7, 8, 9, 0xa, 0xb, 0xc, 0xd, 0xe]);

//     var packs = BlePacket.pack(productConfig.aesKey, cmdOrder, content);
//     expect(packs.length, 2);

//     packs = BlePacket.pack(productConfig.aesKey, cmdOrder, content);

//     expect(
//         packs[0],
//         Uint8List.fromList([
//           0xa5,
//           4 | (BlePacket.protocolVersion << 4),
//           0,
//           0x14,
//           0x44,
//           0x52,
//           0x3F,
//           0x96,
//           0x4D,
//           0xD6,
//           0x92,
//           0x58,
//           0xE7,
//           0xB3,
//           0xD2,
//           0x9A,
//           0x0C,
//           0xF7,
//           0x51,
//           0x8D
//         ]));
//     expect(
//         packs[1],
//         Uint8List.fromList([
//           0xa5,
//           1 | (BlePacket.protocolVersion << 4),
//           0,
//           0x14,
//           0xDD,
//           0x4B,
//           0x9F,
//           0x44,
//           0x5E,
//           0xB0,
//           0x2F,
//           0x2C,
//           0x0E,
//           0x7B,
//           0xB1,
//           0x2C,
//           0x3F,
//           0xE8,
//           0x04,
//           0x4B
//         ]));
//   });
}


////////////////////////
// void main() {
//   test("get packet field index", () {
//     expect(0, BlePacket.getStarterIndex());
//     expect(1, BlePacket.getPackTypeIndex());
//     expect(2, BlePacket.getLengthIndex());
//     expect(4, BlePacket.getCmdOrderIndex());
//     expect(4, BlePacket.getContentIndex());
//   });

//   test("set packet field - plain", () {
//     Uint8List c = Uint8List.fromList([0xff, 0xee, 1, 2, 3, 4]);
//     int packType = 0xf;
//     int cmdOrder = 0xffee;
//     BlePacket p = BlePacketPlain(packType, cmdOrder, c);

//     expect(BlePacket.starterBytePlain, p.packetData.getUint8(0));
//     expect(0xf, p.packetData.getUint8(BlePacket.getPackTypeIndex()));
//     expect(p.getWholeLen(), p.packetData.getUint16(BlePacket.getLengthIndex()));
//     expect(0xffee, p.packetData.getUint16(BlePacket.getCmdOrderIndex()));
//     int contentIndex = BlePacket.getContentIndex();
//     expect(0xff, p.packetData.getUint8(contentIndex));
//     expect(0xee, p.packetData.getUint8(contentIndex + 1));
//     expect(1, p.packetData.getUint8(contentIndex + 2));
//     expect(2, p.packetData.getUint8(contentIndex + 3));
//     expect(3, p.packetData.getUint8(contentIndex + 4));
//     expect(4, p.packetData.getUint8(contentIndex + 5));
//   });

//   test("set packet field - encrypt", () {
//     Uint8List c = Uint8List.fromList([0xff, 0xee, 1, 2, 3, 4]);
//     Uint8List cEncode = aesDec128Encrypt(c, 'vtwhc3jovyzvd4h4');
//     int packType = 0xf;
//     int cmdOrder = 0xffee;
//     BlePacket p = BlePacketEncrypt(packType, cmdOrder, cEncode, c);

//     expect(BlePacket.starterByteEncode, p.packetData.getUint8(0));
//     expect(0xf, p.packetData.getUint8(BlePacket.getPackTypeIndex()));
//     expect(p.getWholeLen(), p.packetData.getUint16(BlePacket.getLengthIndex()));
//     expect(0xffee, p.cmdOrder);
//     int contentIndex = BlePacket.getContentIndex();
//     Uint8List plainContent = p.getPlainContent();
//     expect(0xff, plainContent[0]);
//     expect(0xee, plainContent[1]);
//     expect(
//         p.content,
//         Uint8List.fromList([
//           0x3C,
//           0xCC,
//           0xB8,
//           0x65,
//           0xD2,
//           0x4F,
//           0xD9,
//           0x62,
//           0x5E,
//           0x99,
//           0x89,
//           0xBE,
//           0xBF,
//           0x99,
//           0x27,
//           0x53
//         ]));
//   });

//   test('getPackCountWithoutEncrypt', () {
//     expect(BlePacketPlain.getPackCount(16, 14), 1);
//     expect(BlePacketPlain.getPackCount(16, 15), 2);
//     expect(BlePacketPlain.getPackCount(16, 16), 2);
//     expect(BlePacketPlain.getPackCount(16, 27), 2);
//     expect(BlePacketPlain.getPackCount(16, 28), 2);
//     expect(BlePacketPlain.getPackCount(16, 29), 3);
//   });

//   test('getPackCountWithEncrypt', () {
//     expect(BlePacketEncrypt.getPackCount(16, 13), 1);
//     expect(BlePacketEncrypt.getPackCount(16, 14), 2);
//     expect(BlePacketEncrypt.getPackCount(16, 15), 2);
//     expect(BlePacketEncrypt.getPackCount(16, 16), 2);
//     expect(BlePacketEncrypt.getPackCount(16, 26), 2);
//     expect(BlePacketEncrypt.getPackCount(16, 27), 3);
//     expect(BlePacketEncrypt.getPackCount(16, 28), 3);
//   });

//   test('getSubPacketContent - plain', () {
//     Uint8List rawContent = Uint8List.fromList([1, 2, 3, 4, 5, 6, 7]);
//     int contentCapacity = 4;
//     int cmdOrder = 0xffee;
//     expect(
//         BlePacketPlain.getSubPacketContent(
//             cmdOrder, rawContent, 0, contentCapacity),
//         Uint8List.fromList([0xff, 0xee, 1, 2]));
//     expect(
//         BlePacketPlain.getSubPacketContent(
//             cmdOrder, rawContent, 1, contentCapacity),
//         Uint8List.fromList([0xff, 0xee, 3, 4]));
//     expect(
//         BlePacketPlain.getSubPacketContent(
//             cmdOrder, rawContent, 2, contentCapacity),
//         Uint8List.fromList([0xff, 0xee, 5, 6]));
//     expect(
//         BlePacketPlain.getSubPacketContent(
//             cmdOrder, rawContent, 3, contentCapacity),
//         Uint8List.fromList([0xff, 0xee, 7]));
//     expect(
//         BlePacketPlain.getSubPacketContent(cmdOrder, null, 0, contentCapacity),
//         [0xff, 0xee]);
//     expect(
//         BlePacketPlain.getSubPacketContent(
//             cmdOrder, Uint8List.fromList([]), 0, contentCapacity),
//         Uint8List.fromList([0xff, 0xee]));
//   });

//   test('getSubPacketContent - encrypt', () {
//     String aesKey = 'vtwhc3jovyzvd4h4';

//     Uint8List rawContent = Uint8List.fromList(
//         [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 0xa, 0xb, 0xc, 0xd, 0xe, 0xf]);
//     int contentCapacity = 16;
//     int cmdOrder = 0xffee;
//     var res = BlePacketEncrypt.getSubPacketContent(
//         cmdOrder, rawContent, 0, contentCapacity, aesKey);
//     expect(
//         res[0],
//         Uint8List.fromList(
//             [0xff, 0xee, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 0xa, 0xb, 0xc]));
//     expect(
//         res[1],
//         Uint8List.fromList([
//           0xD4,
//           0xDB,
//           0x6B,
//           0x6B,
//           0xF9,
//           0x87,
//           0xEE,
//           0x09,
//           0xB7,
//           0x18,
//           0x8C,
//           0x07,
//           0x10,
//           0x64,
//           0x80,
//           0xC8
//         ]));

//     res = BlePacketEncrypt.getSubPacketContent(
//         cmdOrder, rawContent, 1, contentCapacity, aesKey);

//     expect(res[0], Uint8List.fromList([0xff, 0xee, 0xd, 0xe, 0xf]));
//     expect(
//         res[1],
//         Uint8List.fromList([
//           0x5E,
//           0xD3,
//           0x8F,
//           0x2D,
//           0x87,
//           0x05,
//           0x1B,
//           0xF3,
//           0x39,
//           0x93,
//           0x68,
//           0x57,
//           0x4C,
//           0x3E,
//           0x8F,
//           0x73
//         ]));

//     res = BlePacketEncrypt.getSubPacketContent(
//         cmdOrder, null, 0, contentCapacity, aesKey);
//     expect(res[0], [0xff, 0xee]);
//     expect(
//         res[1],
//         Uint8List.fromList([
//           0xFC,
//           0x78,
//           0xFC,
//           0x5D,
//           0xF0,
//           0xA9,
//           0x23,
//           0x02,
//           0x3D,
//           0xB7,
//           0xF9,
//           0x30,
//           0x23,
//           0x2F,
//           0x79,
//           0x6E
//         ]));

//     rawContent = Uint8List.fromList([
//       0,
//       1,
//       2,
//       3,
//       4,
//       5,
//       6,
//       7,
//       8,
//       9,
//       0xa,
//       0xb,
//       0xc,
//       0xd,
//       0xe,
//       0xf,
//       0,
//       1,
//       2,
//       3,
//       4,
//       5,
//       6,
//       7,
//       8,
//       9
//     ]);

//     res = BlePacketEncrypt.getSubPacketContent(
//         cmdOrder, rawContent, 0, contentCapacity, aesKey);
//     expect(
//         res[0],
//         Uint8List.fromList(
//             [0xff, 0xee, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 0xa, 0xb, 0xc]));
//     res = BlePacketEncrypt.getSubPacketContent(
//         cmdOrder, rawContent, 1, contentCapacity, aesKey);
//     expect(
//         res[0],
//         Uint8List.fromList(
//             [0xff, 0xee, 0xd, 0xe, 0xf, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9]));

//     rawContent = Uint8List.fromList([
//       0,
//       1,
//       2,
//       3,
//       4,
//       5,
//       6,
//       7,
//       8,
//       9,
//       0xa,
//       0xb,
//       0xc,
//       0xd,
//       0xe,
//       0xf,
//       0,
//       1,
//       2,
//       3,
//       4,
//       5,
//       6,
//       7,
//       8,
//       9,
//       0xa
//     ]);

//     res = BlePacketEncrypt.getSubPacketContent(
//         cmdOrder, rawContent, 0, contentCapacity, aesKey);
//     expect(
//         res[0],
//         Uint8List.fromList(
//             [0xff, 0xee, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 0xa, 0xb, 0xc]));
//     res = BlePacketEncrypt.getSubPacketContent(
//         cmdOrder, rawContent, 1, contentCapacity, aesKey);
//     expect(
//         res[0],
//         Uint8List.fromList(
//             [0xff, 0xee, 0xd, 0xe, 0xf, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9]));
//     res = BlePacketEncrypt.getSubPacketContent(
//         cmdOrder, rawContent, 2, contentCapacity, aesKey);
//     expect(res[0], Uint8List.fromList([0xff, 0xee, 0xa]));
//   });

//   test("packWithEncrypt 1", () {
//     Config.gMtu = 20;
//     int cmdOrder = 0xffee;
//     ProductConfig productConfig = ProductConfig(
//         'name', 'vtwhc3jovyzvd4h4', 'serviceUuid', 'characterUuid', 'ABC_');

//     Config.gUseAesEncrypt = true;
//     Uint8List? content;
//     var packs = BlePacket.pack(productConfig.aesKey, cmdOrder, content);
//     expect(packs.length, 1);
//     expect(
//         packs[0],
//         Uint8List.fromList([
//           0xA5,
//           5,
//           0,
//           0x14,
//           0xFC,
//           0x78,
//           0xFC,
//           0x5D,
//           0xF0,
//           0xA9,
//           0x23,
//           0x02,
//           0x3D,
//           0xB7,
//           0xF9,
//           0x30,
//           0x23,
//           0x2F,
//           0x79,
//           0x6E
//         ]));
//   });

//   test("packWithEncrypt 2", () {
//     Config.gMtu = 20;
//     int cmdOrder = 0xffee;
//     ProductConfig productConfig = ProductConfig(
//         'name', 'vtwhc3jovyzvd4h4', 'serviceUuid', 'characterUuid', 'ABC_');

//     Config.gUseAesEncrypt = true;
//     var content = Uint8List.fromList([1, 2, 3, 4, 5, 6]);

//     var packs = BlePacket.pack(productConfig.aesKey, cmdOrder, content);
//     expect(packs.length, 1);
//     expect(
//         packs[0],
//         Uint8List.fromList([
//           0xA5,
//           5,
//           0,
//           0x14,
//           0xDA,
//           0x21,
//           0x35,
//           0x28,
//           0x52,
//           0xFF,
//           0x19,
//           0x8C,
//           0x3D,
//           0x30,
//           0x36,
//           0x39,
//           0xC6,
//           0x9E,
//           0x80,
//           0x27
//         ]));
//   });

//   test("packWithEncrypt 3", () {
//     Config.gMtu = 20;
//     int cmdOrder = 0xffee;
//     ProductConfig productConfig = ProductConfig(
//         'name', 'vtwhc3jovyzvd4h4', 'serviceUuid', 'characterUuid', 'ABC_');

//     Config.gUseAesEncrypt = true;
//     var content =
//         Uint8List.fromList([1, 2, 3, 4, 5, 6, 7, 8, 9, 0xa, 0xb, 0xc, 0xd]);

//     var packs = BlePacket.pack(productConfig.aesKey, cmdOrder, content);
//     expect(packs.length, 1);
//     expect(
//         packs[0],
//         Uint8List.fromList([
//           0xa5,
//           5,
//           0,
//           0x14,
//           0x44,
//           0x52,
//           0x3F,
//           0x96,
//           0x4D,
//           0xD6,
//           0x92,
//           0x58,
//           0xE7,
//           0xB3,
//           0xD2,
//           0x9A,
//           0x0C,
//           0xF7,
//           0x51,
//           0x8D
//         ]));
//   });

//   test("packWithEncrypt 4", () {
//     Config.gMtu = 20;
//     int cmdOrder = 0xffee;
//     ProductConfig productConfig = ProductConfig(
//         'name', 'vtwhc3jovyzvd4h4', 'serviceUuid', 'characterUuid', 'ABC_');

//     Config.gUseAesEncrypt = true;
//     var content = Uint8List.fromList(
//         [1, 2, 3, 4, 5, 6, 7, 8, 9, 0xa, 0xb, 0xc, 0xd, 0xe]);

//     var packs = BlePacket.pack(productConfig.aesKey, cmdOrder, content);
//     expect(packs.length, 2);

//     packs = BlePacket.pack(productConfig.aesKey, cmdOrder, content);

//     expect(
//         packs[0],
//         Uint8List.fromList([
//           0xa5,
//           4,
//           0,
//           0x14,
//           0x44,
//           0x52,
//           0x3F,
//           0x96,
//           0x4D,
//           0xD6,
//           0x92,
//           0x58,
//           0xE7,
//           0xB3,
//           0xD2,
//           0x9A,
//           0x0C,
//           0xF7,
//           0x51,
//           0x8D
//         ]));
//     expect(
//         packs[1],
//         Uint8List.fromList([
//           0xa5,
//           1,
//           0,
//           0x14,
//           0xDD,
//           0x4B,
//           0x9F,
//           0x44,
//           0x5E,
//           0xB0,
//           0x2F,
//           0x2C,
//           0x0E,
//           0x7B,
//           0xB1,
//           0x2C,
//           0x3F,
//           0xE8,
//           0x04,
//           0x4B
//         ]));
//   });

//   test("packWithoutEncrypt", () {
//     Config.gMtu = 20;
//     Config.gUseAesEncrypt = false;
//     Uint8List? content;

//     var pack1 = BlePacket.pack(null, 0xffee, content);
//     expect(pack1, [
//       Uint8List.fromList([0xa4, 5, 0, 6, 0xff, 0xee])
//     ]);

//     Uint8List? content1 = Uint8List.fromList([]);
//     var pack2 = BlePacket.pack(null, 0xffee, content1);
//     expect(pack2, [
//       Uint8List.fromList([0xa4, 5, 0, 6, 0xff, 0xee])
//     ]);

//     Uint8List? content3 =
//         Uint8List.fromList([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15]);
//     var pack3 = BlePacket.pack(null, 0xffee, content3);
//     expect(
//       pack3,
//       [
//         Uint8List.fromList(
//           [
//             0xa4,
//             4,
//             0,
//             20,
//             0xff,
//             0xee,
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
//             14
//           ],
//         ),
//         Uint8List.fromList([0xa4, 1, 0, 7, 0xff, 0xee, 15])
//       ],
//     );
//   });

//   test('parsePackType', () {
//     Uint8List buf =
//         Uint8List.fromList([0xa5, 1 << 2, 0, 0xa, 0xff, 0xee, 2, 0x45]);
//     int packType = BlePacket.parsePackType(buf);
//     expect(packType, 1 << 2);
//   });

//   test('parseLen', () {
//     Uint8List buf =
//         Uint8List.fromList([0xa5, 1 << 2, 0, 0xa, 0xff, 0xee, 2, 0x45]);
//     int len = BlePacket.parseLength(buf);
//     expect(len, 0xa);
//   });

//   test('parseCmdOrder', () {
//     Uint8List buf =
//         Uint8List.fromList([0xa5, 1 << 2, 0, 0xa, 0xff, 0xee, 2, 0x45]);
//     int cmd = BlePacket.parseCmdOrder(buf);
//     expect(cmd, 0xffee);
//   });

//   test("parseContent", () {
//     Uint8List buf = Uint8List.fromList([0xa5, 1 << 2, 0, 0x7, 0xff, 0xee, 2]);
//     var content = BlePacket.parseContent(buf);
//     expect(content, Uint8List.fromList([0xff, 0xee, 2]));
//   });

//   test('generatePackType', () {
//     var packType = BlePacket.generatePackType(0, 1);
//     expect(packType, 0x15);
//   });
// }
