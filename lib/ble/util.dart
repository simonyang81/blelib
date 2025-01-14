import 'dart:typed_data';

extension BleString on String {
  int startWithInList(List<String> list) {
    for (int i = 0; i < list.length; i++) {
      if (startsWith(list[i])) {
        return i;
      }
    }

    return -1;
  }

  bool uuidInList(List<String> list) {
    var lowerThis = toLowerCase();
    for (var element in list) {
      if (lowerThis == element.toLowerCase()) {
        return true;
      }
    }

    return false;
  }

  int getPrefixIndex(List<String> prefixList) {
    int len = prefixList.length;
    int index = -1;
    for (int i = 0; i < len; i++) {
      if (startsWith(prefixList[i])) {
        return i;
      }
    }

    return index;
  }

  int getScanFilterUuidIndex(List<String> uuidList) {
    int index = -1;
    int len = uuidList.length;
    var lowerThis = toLowerCase();
    for (int i = 0; i < len; i++) {
      if (lowerThis.compareTo(uuidList[i].toLowerCase()) == 0) {
        return i;
      }
    }

    return index;
  }
}

Uint8List doXor(Uint8List a, Uint8List b, int size) {
  Uint8List result = Uint8List(size);
  for (int i = 0; i < size; i++) {
    result[i] = a[i] ^ b[i];
  }
  return result;
}
