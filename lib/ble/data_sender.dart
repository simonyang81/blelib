part of blelib;

void sendMessage(BleDevice device, int cmd, Uint8List? content) {
  var aesKey = device.productConfig?.aesKey;
  final packets = BlePacket.pack(aesKey, cmd, content);
  //
  // //cxx_test
  // for (final item in packets) {
  //   BlePacket.store(device, BlePacket.unpack(device, item)!);
  // }
  // BlePacket.receiveBuffer.clear();
  // ekLog("vs.length:${BlePacket.receiveBuffer.length}");
  //
  sendBLEMessage(device, packets);
}

void sendRawMessage(BleDevice device, Uint8List data) {
  sendRawBleMessage(device, data);
}
