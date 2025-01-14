import 'dart:math';
import 'dart:typed_data';

import 'package:blelib/ble/ble_packet.dart';
import 'package:blelib/blelib.dart';

class BlePacketPlain extends BlePacket {
  BlePacketPlain(int packType, int cmdOrder, Uint8List content)
      : super(packType, cmdOrder, content, false) {
    setStarter();
  }

  @override
  void setStarter() {
    packetData.setUint8(
        BlePacket.getStarterIndex(), BlePacket.starterBytePlain);
  }

  static int getMaxContentLenWithEncrypt() {
    int maxContentSize = (Config.gMtu - BlePacket.getEnvelopLen()) ~/ 16 * 16;

    return maxContentSize;
  }

  static int getPackCount(int contentCapacity, int totalRawContentLen) {
    if (totalRawContentLen == 0) return 1;

    int packCount = (totalRawContentLen - 1) ~/
            (contentCapacity - BlePacket.formatLenCmdOrder) +
        1;

    return packCount;
  }

  // 没有加密的情况下单包能放下的最大内容
  static int getMaxContentLenWithoutEncrypt() {
    int checksumLen = 0;
    if (Config.gUseChecksum) {
      // 在content字段留出一个字节来放checksum
      checksumLen = 1;
    }
    return Config.gMtu - BlePacket.getEnvelopLen() - checksumLen;
  }

  // 不加密情况下的打包
  static List<Uint8List> packWithoutEncrypt(Uint8List? content, int cmdOrder) {
    List<Uint8List> packs = [];
    int contentCapacity = BlePacketPlain.getMaxContentLenWithoutEncrypt();

    int nPacks =
        getPackCount(contentCapacity, content == null ? 0 : content.length);

    for (int i = 0; i < nPacks; i++) {
      int packType = BlePacket.generatePackType(i, nPacks);
      Uint8List c = getSubPacketContent(cmdOrder, content, i, contentCapacity);
      Uint8List pack = packSingle(packType, cmdOrder, c);

      packs.add(pack);
    }
    return packs;
  }

  static Uint8List getSubPacketContent(
      int cmdOrder, Uint8List? rawContent, int i, int contentCapacity) {
    int firstCmdByte = cmdOrder >> 8;
    int secondCmdByte = (cmdOrder & 0xff);

    if (rawContent == null) {
      if (Config.gUseChecksum) {
        return Uint8List.fromList([
          firstCmdByte,
          secondCmdByte,
          BlePacket.calculateChecksum(
              Uint8List.fromList([firstCmdByte, secondCmdByte]))
        ]);
      } else {
        return Uint8List.fromList([firstCmdByte, secondCmdByte]);
      }
    }
    int rawContentCapacity = (contentCapacity - BlePacket.formatLenCmdOrder);
    Uint8List c = rawContent.sublist(i * rawContentCapacity,
        min(i * rawContentCapacity + rawContentCapacity, rawContent.length));

    int checksumLen = Config.gUseChecksum ? 1 : 0;
    Uint8List res = Uint8List(c.length + 2 + checksumLen);
    res[0] = firstCmdByte;
    res[1] = secondCmdByte;
    res.setAll(2, c);
    if (Config.gUseChecksum) {
      res[res.length - 1] = BlePacket.calculateChecksum(res);
    }

    return res;
  }

  static Uint8List packSingle(int packType, int cmdOrder, Uint8List content) {
    BlePacket p;

    p = BlePacketPlain(packType, cmdOrder, content);

    return p.getBuffer();
  }
}
