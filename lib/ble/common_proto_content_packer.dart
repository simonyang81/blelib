import 'dart:convert';
import 'dart:typed_data';

import 'package:blelib/interface/ble_send_pack_interface.dart';

// 对协议格式的content字段的原始内容进行打包
class CommonProtoContentPacker implements BleCommonSendPackInterface {
  @override
  Uint8List? packGetDeviceName() {
    Uint8List content = Uint8List.fromList([]);
    return content;
  }

  @override
  Uint8List? packGetVersion() {
    Uint8List content = Uint8List.fromList([]);
    return content;
  }

  @override
  Uint8List? packKeyAuth(Uint8List keyAuth) {
    List<int> tmp = [];
    var len = keyAuth.length;
    tmp.add((len & 0x0000FF00) >> 8);
    tmp.add((len & 0x000000FF));
    tmp.addAll(keyAuth);
    Uint8List content = Uint8List.fromList(tmp);
    return content;
  }

  @override
  Uint8List? packNotifyMode(int result) {
    List<int> tmp = [];
    tmp.add(result);
    Uint8List content = Uint8List.fromList(tmp);
    return content;
  }

  @override
  Uint8List? packNotifyShutdown(int result) {
    List<int> tmp = [];
    tmp.add(result);
    Uint8List content = Uint8List.fromList(tmp);
    return content;
  }

  @override
  Uint8List? packNotifyStart(int result) {
    List<int> tmp = [];
    tmp.add(result);
    Uint8List content = Uint8List.fromList(tmp);
    return content;
  }

  @override
  Uint8List? packNotifyStop(int result) {
    List<int> tmp = [];
    tmp.add(result);
    Uint8List content = Uint8List.fromList(tmp);
    return content;
  }

  @override
  Uint8List? packNotifyLevel(int result) {
    List<int> tmp = [];
    tmp.add(result);
    Uint8List content = Uint8List.fromList(tmp);
    return content;
  }

  @override
  Uint8List? packReadDefaultMode() {
    Uint8List content = Uint8List.fromList([]);
    return content;
  }

  @override
  Uint8List? packReadEikCode() {
    Uint8List content = Uint8List.fromList([]);
    return content;
  }

  @override
  Uint8List? packReadMode() {
    List<int> tmp = [];

    Uint8List content = Uint8List.fromList(tmp);
    return content;
  }

  @override
  Uint8List? packReadStatus() {
    Uint8List content = Uint8List.fromList([]);
    return content;
  }

  @override
  Uint8List? packReadStrength() {
    List<int> tmp = [];

    Uint8List content = Uint8List.fromList(tmp);
    return content;
  }

  @override
  Uint8List? packReverseKeyAuth(Uint8List reverseKeyAuth) {
    return null;
  }

  @override
  Uint8List? packSetDefaultMode(int mode) {
    List<int> tmp = [];
    tmp.add(mode);
    Uint8List content = Uint8List.fromList(tmp);
    return content;
  }

  // @override
  // Uint8List? packSetDeviceCode(
  //     int codeVersion, int length, int uniqueCode, int deviceCode) {
  //   Uint8List content = Uint8List(13);
  //   content[0] = codeVersion;
  //   content[1] = ((length & 0x0000FF00) >> 8);
  //   content[2] = ((length & 0x000000FF));
  //   content[3] = ((uniqueCode & 0xFF0000000000) >> 40);
  //   content[4] = ((uniqueCode & 0xFF00000000) >> 32);
  //   content[5] = ((uniqueCode & 0xFF000000) >> 24);
  //   content[6] = ((uniqueCode & 0x00FF0000) >> 16);
  //   content[7] = ((uniqueCode & 0x0000FF00) >> 8);
  //   content[8] = ((uniqueCode & 0x000000FF));
  //   content[9] = ((deviceCode & 0xFF000000) >> 24);
  //   content[10] = ((deviceCode & 0x00FF0000) >> 16);
  //   content[11] = ((deviceCode & 0x0000FF00) >> 8);
  //   content[12] = ((deviceCode & 0x000000FF));
  //   return content;
  // }

  @override
  Uint8List? packSetDeviceName(String deviceName) {
    Uint8List list = Uint8List.fromList(utf8.encode(deviceName));
    List<int> tmp = [];
    tmp.add(list.length);
    tmp.addAll(list);

    Uint8List content = Uint8List.fromList(tmp);
    return content;
  }

  @override
  Uint8List? packSetDevicePin(String devicePin) {
    List<int> tmp = [];
    tmp.add(devicePin.length);
    for (int i = 0; i < devicePin.length; i++) {
      tmp.add(devicePin.codeUnitAt(i));
    }

    Uint8List content = Uint8List.fromList(tmp);
    return content;
  }

  @override
  Uint8List? packSetMode(int mode) {
    List<int> tmp = [];
    tmp.add(mode);
    Uint8List content = Uint8List.fromList(tmp);
    return content;
  }

  @override
  Uint8List? packSetStart() {
    Uint8List content = Uint8List.fromList([]);
    return content;
  }

  @override
  Uint8List? packSetStop() {
    Uint8List content = Uint8List.fromList([]);
    return content;
  }

  @override
  Uint8List? packSetLevel(int level) {
    List<int> tmp = [];
    tmp.add(level);
    Uint8List content = Uint8List.fromList(tmp);
    return content;
  }

  @override
  Uint8List? packSetTimeLen(int timeLen) {
    List<int> tmp = [];
    tmp.add(timeLen);
    Uint8List content = Uint8List.fromList(tmp);
    return content;
  }

  @override
  Uint8List? packShutdown() {
    Uint8List content = Uint8List.fromList([]);
    return content;
  }

  @override
  Uint8List? packStartSession(int randNum) {
    Uint8List content = Uint8List(4);
    content[0] = ((randNum & 0xFF000000) >> 24);
    content[1] = ((randNum & 0x00FF0000) >> 16);
    content[2] = ((randNum & 0x0000FF00) >> 8);
    content[3] = ((randNum & 0x000000FF));
    return content;
  }

  @override
  Uint8List? packSyncTime(
      int year, int month, int day, int hour, int minute, int second) {
    List<int> tmp = [];
    tmp.add((year & 0x0000FF00) >> 8);
    tmp.add((year & 0x000000FF));
    tmp.add(month);
    tmp.add(day);
    tmp.add(hour);
    tmp.add(minute);
    tmp.add(second);
    Uint8List content = Uint8List.fromList(tmp);
    return content;
  }

  @override
  Uint8List? packNotifyBattery(int result) {
    List<int> tmp = [];
    tmp.add(result);
    Uint8List content = Uint8List.fromList(tmp);
    return content;
  }

  @override
  Uint8List? packNotifyPause(int result) {
    List<int> tmp = [];
    tmp.add(result);
    Uint8List content = Uint8List.fromList(tmp);
    return content;
  }

  @override
  Uint8List? packSetPause() {
    Uint8List content = Uint8List.fromList([]);
    return content;
  }

  @override
  Uint8List? packNotifyTimeLen(int result) {
    List<int> tmp = [];
    tmp.add(result);
    Uint8List content = Uint8List.fromList(tmp);
    return content;
  }

  @override
  Uint8List? packReadTimeLen() {
    Uint8List content = Uint8List.fromList([]);
    return content;
  }

  @override
  Uint8List? packReadBattery() {
    Uint8List content = Uint8List.fromList([]);
    return content;
  }

  @override
  Uint8List? packReadDefaultLevel() {
    Uint8List content = Uint8List.fromList([]);
    return content;
  }

  @override
  Uint8List? packSetDefaultLevel(int level) {
    List<int> tmp = [];
    tmp.add(level);
    Uint8List content = Uint8List.fromList(tmp);
    return content;
  }

  @override
  Uint8List? packReadTestFlag() {
    Uint8List content = Uint8List.fromList([]);
    return content;
  }

  @override
  Uint8List? packSetTestFlag(int flag) {
    List<int> tmp = [];
    tmp.add(flag);
    Uint8List content = Uint8List.fromList(tmp);
    return content;
  }

  @override
  Uint8List? packSendBigDataTest(Uint8List content) {
    return content;
  }

  @override
  Uint8List? packReadPropertyCode() {
    Uint8List content = Uint8List.fromList([]);
    return content;
  }
}
