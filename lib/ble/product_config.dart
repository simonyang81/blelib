class ProductConfig {
  String name; // 只是一个识别字符，没有参与业务逻辑

  String aesKey;
  String serviceUuid;
  String writeCharacterUuid;
  String notifyCharacterUuid;
  String? prefix; // 蓝牙广播的名称前缀
  String? scanUuid;

  ProductConfig(this.name, this.aesKey, this.serviceUuid,
      this.writeCharacterUuid, this.notifyCharacterUuid,
      [this.prefix = '', this.scanUuid = '']);
}
