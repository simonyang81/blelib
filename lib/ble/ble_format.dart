import 'dart:io';
import 'dart:typed_data';

import 'package:blelib/ble/crypto.dart';

import '../blelib.dart';
import 'log.dart';
/*
起始标志: 2 bytes [A5A5]
Version协议版本号: 1 byte	[1]
Pack Type（包类型）:	1 byte   
                      首包：0b 100
                      中间包：0b 010
                      尾包：0b 001
                      既是首包也是尾包：0b  101
Length(当前包长度): 2 bytes [高位在前Big-Endian]
Command Order:	2 bytes[高位在前Big-Endian]
Command Content: x bytes
checksum: 1 byte
,	1 byte	1 byte	2 bytes	2 byte	x bytes	1 byte
*/

int lastSendTimestamp = 0;

int getAesEncryptLen(int rawLen) {
  int formatLen = rawLen + 5;
  return ((formatLen % 16) + 1) * 16;
}

List<Uint8List> packBLEMessage(Uint8List msg, BleDevice device) {
  List<Uint8List> packs = [];

  if (device.productConfig == null) return packs;

  String aesKey = device.productConfig!.aesKey;

  //AES 128 加密
  Uint8List messageContent = aesDec128Encrypt(msg, aesKey);

  int nPack = (messageContent.length - 1) ~/ 20 + 1;
  for (int i = 0; i < nPack; i++) {
    int segLen = (i < (nPack - 1) ? 20 : messageContent.length % 20);
    if (segLen == 0) segLen = 20;
    Uint8List segment = Uint8List(segLen);
    for (int j = 0; j < segLen; j++) {
      segment[j] = messageContent[i * 20 + j];
    }
    packs.add(segment);
  }

  return packs;
}

void sendBLEMessage(BleDevice device, List<Uint8List> packs) {
  ekLog('写入的数据为$packs');

  var nowTimestamp = DateTime.now().millisecondsSinceEpoch;
  if (nowTimestamp - lastSendTimestamp < Config.gSendMessageDelayMs) {
    sleep(Duration(milliseconds: Config.gSendMessageDelayMs));
  }

  for (var i = 0; i < packs.length; i++) {
    if (i != 0) {
      sleep(Duration(milliseconds: Config.gSendMessageDelayMs));
    }
    // //cxx_test
    // ekLog("====>> sendBleMessage pack $i length: ${packs[i].length}");

    BleDataChannel.instance.writeValue(packs[i], device);
    lastSendTimestamp = DateTime.now().millisecondsSinceEpoch;
  }
}

void sendBigBLEMessage(BleDevice device, Uint8List data) {
  //ekLog('写入的数据为${packs}');

  BleDataChannel.instance.writeValue(data, device);
}

void sendMessageByUuid(
    BleDevice device, String serviceUuid, String charaUuid, Uint8List data) {
  BleDataChannel.instance
      .writeValueByUuid(device, serviceUuid, charaUuid, data);
}

Future sendRawBleMessage(BleDevice device, Uint8List data) async {
  await BleDataChannel.instance.writeValue(data, device);
}
