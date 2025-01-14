import 'dart:math';
import 'dart:typed_data';

import 'package:blelib/ble/ble_packet.dart';
import 'package:blelib/ble/crypto.dart';
import 'package:blelib/blelib.dart';

class BlePacketEncrypt extends BlePacket {
  Uint8List plainContent;

  BlePacketEncrypt(
      int packType, int cmdOrder, Uint8List content, this.plainContent)
      : super(packType, cmdOrder, content, true) {
    setStarter();
  }

  @override
  Uint8List getPlainContent() {
    return plainContent;
  }

  @override
  void setStarter() {
    packetData.setUint8(
        BlePacket.getStarterIndex(), BlePacket.starterByteEncode);
  }

  static int getPackCount(int contentCapacity, int totalRawContentLen) {
    assert(contentCapacity % 16 == 0);
    if (totalRawContentLen == 0) return 1;

    int checksumLen = 0;
    if (Config.gUseChecksum) {
      // 给checksum留一个字节的位置
      checksumLen = 1;
    }

    int packetPureContentLen = contentCapacity -
        BlePacket.aesPadSize -
        BlePacket.formatLenCmdOrder -
        checksumLen;

    int leftLen = totalRawContentLen % packetPureContentLen;
    if (leftLen > 0) {
      // 余数不满一个长度，则计算为一个长度
      totalRawContentLen += (packetPureContentLen - leftLen);
    }

    int packCount = totalRawContentLen ~/ packetPureContentLen;

    return packCount;
  }

  static List<Uint8List> getSubPacketContent(int cmdOrder, Uint8List? content,
      int i, int contentCapacity, String aesKey) {
    int firstCmdByte = cmdOrder >> 8;
    int secondCmdByte = (cmdOrder & 0xff);
    Uint8List plainContentBuf;
    int checksumLen = Config.gUseChecksum ? 1 : 0;

    if (content == null) {
      if (checksumLen == 0) {
        plainContentBuf = Uint8List.fromList([firstCmdByte, secondCmdByte]);
      } else {
        plainContentBuf = Uint8List.fromList([
          firstCmdByte,
          secondCmdByte,
          BlePacket.calculateChecksum(
              Uint8List.fromList([firstCmdByte, secondCmdByte]))
        ]);
      }
    } else {
      int rawContentCapacity =
          (contentCapacity - BlePacket.formatLenCmdOrder - 1) - checksumLen;
      var plainPureContent = content.sublist(i * rawContentCapacity,
          min(i * rawContentCapacity + rawContentCapacity, content.length));

      plainContentBuf = Uint8List(
          plainPureContent.length + BlePacket.formatLenCmdOrder + checksumLen);
      plainContentBuf[0] = firstCmdByte;
      plainContentBuf[1] = secondCmdByte;
      plainContentBuf.setAll(2, plainPureContent);
      if (checksumLen == 1) {
        plainContentBuf[plainContentBuf.length - 1] =
            BlePacket.calculateChecksum(plainContentBuf);
      }
    }

    List<Uint8List> res = [plainContentBuf];

    res.add(aesDec128Encrypt(plainContentBuf, aesKey));
    return res;
  }

  static int getMaxContentLenWithEncrypt() {
    int maxContentSize = (Config.gMtu - BlePacket.getEnvelopLen()) ~/ 16 * 16;

    return maxContentSize;
  }

  // 加密情况下的打包
  static List<Uint8List> doPack(
      String aesKey, Uint8List? content, int cmdOrder) {
    List<Uint8List> packs = [];
    int contentCapacity = BlePacketEncrypt.getMaxContentLenWithEncrypt();
    int nPacks =
        getPackCount(contentCapacity, content == null ? 0 : content.length);

    for (int i = 0; i < nPacks; i++) {
      int packType = BlePacket.generatePackType(i, nPacks);
      // 返回明文和加密两个值，为了便于测试
      List<Uint8List> c =
          getSubPacketContent(cmdOrder, content, i, contentCapacity, aesKey);
      assert(c.length == 2);
      // //cxx_test
      // ekLog(">>> doPack c0:${c[0].length}, c1:${c[1].length} c: $c");
      Uint8List pack = packSingle(packType, cmdOrder, c[1], c[0]);

      packs.add(pack);
    }
    return packs;
  }

  static Uint8List packSingle(int packType, int cmdOrder,
      Uint8List encryptContent, Uint8List plainContent) {
    BlePacketEncrypt p =
        BlePacketEncrypt(packType, cmdOrder, encryptContent, plainContent);
    return p.getBuffer();
  }
}
