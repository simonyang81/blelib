import 'dart:typed_data';

import 'package:blelib/ble/ble_packet_encrypt.dart';
import 'package:blelib/ble/ble_packet_plain.dart';
import 'package:blelib/ble/crypto.dart';
import 'package:blelib/ble/log.dart';
import 'package:blelib/blelib.dart';

import 'data_receiver.dart';

class BlePacket {
  static const int protocolVersion = 1;
  static const int starterByteEncode = 0xA5;
  static const int starterBytePlain = 0xA4;
  static const int formatLenStarter = 1;
  static const int formatLenPackType = 1;
  static const int formatLenLength = 2;
  static const int formatLenCmdOrder = 2;
  static const int aesUnitSize = 16;
  static const int aesPadSize = 1;

  static const int packTypeFirstOnly = (1 << 2);
  static const int packTypeLastOnly = 1;
  static const int packTypeMid = (1 << 1);
  static const int packTypeFirstAndLast =
      (packTypeFirstOnly | packTypeLastOnly);

  int packType;
  int cmdOrder;
  bool bEncode;

  // 封包中的content字段(若有加密时，是加密后的内容)
  // 无加密且有checksum时，包含checksum
  late Uint8List content;

  ////late Uint8List plainContent;
  late ByteData packetData; // 整块的封包
  // 接收数据的缓存块
  static List<int> receiveBuffer = [];

  BlePacket(this.packType, this.cmdOrder, Uint8List _content, this.bEncode) {
    if (!verifyContent(_content, bEncode)) return;

    content = _content;

    int packDataLen = getWholeLen();

    packetData = ByteData(packDataLen);
    setPackType(packType);
    setLength(getWholeLen());
    setContent(content);
  }

  bool verifyContent(Uint8List contentBuf, bool bEncode) {
    if (bEncode) {
      if (contentBuf.length < aesUnitSize ||
          contentBuf.length % aesUnitSize != 0) {
        ekLog('Error: content format error when encrypt!!!!!!!!!!!!!!');
        return false;
      }
    } else {
      if (contentBuf.length < formatLenCmdOrder ||
          contentBuf[0] != (cmdOrder >> 8) ||
          contentBuf[1] != (cmdOrder & 0xff)) {
        ekLog('Error: content format error when no encrypt!!!!!!!!!!!!!!');
        return false;
      }
    }

    return true;
  }

  int getWholeLen() {
    return getEnvelopLen() + content.length;
  }

  // 获取信封长度（除内容外的壳的长度）
  static int getEnvelopLen() {
    return formatLenStarter + formatLenPackType + formatLenLength;
  }

  // 加密的情况下单包能放下的最大内容
  // 给定mtu值，反推加密后的最大长度
  // mtu~/ 16 * 16
  // static int getMaxPacketLenWhenEncrypt() {
  //   return Config.gMtu ~/ 16 * 16;
  // }

  static int getStarterIndex() {
    return 0;
  }

  static int getPackTypeIndex() {
    return getStarterIndex() + formatLenStarter;
  }

  static int getLengthIndex() {
    return getPackTypeIndex() + formatLenPackType;
  }

  static int getCmdOrderIndex() {
    return getLengthIndex() + formatLenLength;
  }

  static int getContentIndex() {
    return getLengthIndex() + formatLenLength;
  }

  void setStarter() {}

  // void setChecksum(int checksum) {
  //   packetData.setInt8(getContentIndex() + content.length, checksum);
  // }

  void setPackType(int packType) {
    if (Config.gUseChecksum) {
      packType |= 0x8;
    }

    packetData.setUint8(getPackTypeIndex(), packType);
  }

  void setLength(int len) {
    packetData.setUint16(getLengthIndex(), len);
  }

  void setContent(Uint8List c) {
    int contentIndex = getContentIndex();
    for (int i = 0; i < c.length; i++) {
      packetData.setUint8(contentIndex + i, c[i]);
    }
  }

  Uint8List getPlainContent() {
    return content;
  }

  Uint8List getBuffer() {
    return packetData.buffer.asUint8List();
  }

  static int calculateChecksum(Uint8List buf) {
    int checksum = 0;

    for (var item in buf) {
      checksum += item;
    }
    checksum = checksum & 0xff;
    return checksum;
  }

  static Uint8List appendChecksum(Uint8List? content) {
    int chksum = 0;
    Uint8List contentInclueChksum;
    if (content == null) {
      contentInclueChksum = Uint8List.fromList([0]);
    } else {
      contentInclueChksum = Uint8List(content.length + 1);
      for (int i = 0; i < content.length; i++) {
        contentInclueChksum[i] = content[i];
      }
      chksum = BlePacket.calculateChecksum(content);
      contentInclueChksum[content.length] = chksum;
    }

    return contentInclueChksum;
  }

  // 封包
  static List<Uint8List> pack(
      String? aesKey, int cmdOrder, Uint8List? content) {
    List<Uint8List> packs = [];

    if (Config.gUseAesEncrypt) {
      // 有加密
      if (aesKey == null) return [];
      packs = BlePacketEncrypt.doPack(aesKey, content, cmdOrder);
    } else {
      // 不加密
      packs = BlePacketPlain.packWithoutEncrypt(content, cmdOrder);
    }

    return packs;
  }

  static int parsePackType(Uint8List buf) {
    int packTypeIndex = BlePacket.getPackTypeIndex();
    //包类型，高位4个bit为协议版本号 例如：协议版本为1的首包为：00010100
    int packType = (buf[packTypeIndex] & 0x7); // 取低3个bit位

    return packType;
  }

  static bool parseChecksumBit(Uint8List buf) {
    int packTypeIndex = BlePacket.getPackTypeIndex();
    //包类型，高位4个bit为协议版本号 例如：协议版本为1的首包为：00010100
    bool haveChecksum =
        ((buf[packTypeIndex] & 0x8) == 0) ? false : true; // 取低4个bit的首位位

    return haveChecksum;
  }

  static int parseLength(Uint8List buf) {
    int lenIndex = BlePacket.getLengthIndex();
    int len = (buf[lenIndex] << 8) + buf[lenIndex + 1];
    return len;
  }

  static int parseCmdOrder(Uint8List buf) {
    int cmdIndex = BlePacket.getContentIndex();
    int cmdOrder = (buf[cmdIndex] << 8) + buf[cmdIndex + 1];
    return cmdOrder;
  }

  static Uint8List parseContent(Uint8List buf) {
    //int wholeLen = BlePacket.parseLength(buf);000
    int contentIndex = BlePacket.getContentIndex();

    Uint8List data;

    data = buf.sublist(contentIndex);

    return data;
  }

  // 解包
  static BlePacket? unpack(BleDevice device, Uint8List buf) {
    if (buf.length < getEnvelopLen() ||
        (buf[0] != starterBytePlain && buf[0] != starterByteEncode)) {
      return null;
    }
    bool bUseAesEncrypt = (buf[0] == starterBytePlain ? false : true);
    if (bUseAesEncrypt) {
      // 有加密的情况

      // 先解密
      if (device.productConfig == null) return null;
      String aesKey = device.productConfig!.aesKey;

      // 判断是否存在checksum
      bool haveChecksum = BlePacket.parseChecksumBit(buf);
      int checksumLen = haveChecksum ? 1 : 0;

      // 取出内容字段
      var content = BlePacket.parseContent(buf);

      var decodedContentBuf = aesDec128Decrypt(content, aesKey);
      if (haveChecksum) {
        // 有检验码时，去掉检验码
        decodedContentBuf =
            decodedContentBuf.sublist(0, decodedContentBuf.length - 1);
      }
      Uint8List plainBuf =
          Uint8List(getEnvelopLen() + decodedContentBuf.length);

      plainBuf.setAll(0, buf.sublist(0, 4));
      plainBuf.setAll(4, decodedContentBuf);

      // 解析
      int packType = BlePacket.parsePackType(plainBuf);
      int cmdOrder = BlePacket.parseCmdOrder(plainBuf);
      //var content = BlePacket.parseContent(decodedBuf);

      BlePacketEncrypt p =
          BlePacketEncrypt(packType, cmdOrder, content, decodedContentBuf);
      return p;
    } else {
      // 没有加密的情况

      // 解析封包
      // 判断是否存在checksum
      bool haveChecksum = BlePacket.parseChecksumBit(buf);
      int packType = BlePacket.parsePackType(buf);
      int cmdOrder = BlePacket.parseCmdOrder(buf);
      var content = BlePacket.parseContent(buf);
      if (haveChecksum) {
        // 有checksum时，去掉checksum
        content = content.sublist(0, content.length - 1);
      }

      BlePacketPlain p = BlePacketPlain(packType, cmdOrder, content);
      return p;
    }
  }

  static bool store(BleDevice device, BlePacket packet) {
    if (packet.packType == BlePacket.packTypeFirstOnly ||
        packet.packType == BlePacket.packTypeFirstAndLast) {
      // 发现首包，清理之前buffer
      BlePacket.receiveBuffer.clear();
    }

    // 加入仓库
    var content = packet.getPlainContent();
    if (content.isNotEmpty) {
      BlePacket.receiveBuffer.addAll(content.sublist(2));
    }

    if (packet.packType == BlePacket.packTypeLastOnly ||
        packet.packType == BlePacket.packTypeFirstAndLast) {
      // 发现尾包, 做整个业务包的回调
      if (BleDataChannel.instance.dataRcvHandler != null) {
        // 业务数据回调（主要关注私有协议数据）
        BleDataChannel.instance.dataRcvHandler!(device, packet.cmdOrder,
            Uint8List.fromList(BlePacket.receiveBuffer));
      }

      // 公用协议处理
      postCommonProcess(
          device, packet.cmdOrder, Uint8List.fromList(BlePacket.receiveBuffer));
    }
    return true;
  }

  static int generatePackType(int currentIndex, int nPacks) {
    int packType = 0;
    if (currentIndex == 0) {
      // 为首包
      packType |= (1 << 2);
    }
    if (currentIndex == nPacks - 1) {
      // 为尾包
      packType |= 1;
    }

    if (packType == 0) {
      // 既不是首包，也不是尾包，那就是中间包
      packType |= (1 << 1);
    }

    packType |= (protocolVersion << 4);

    return packType;
  }
}
