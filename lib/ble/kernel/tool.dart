import 'package:blelib/ble/util.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

bool isUuidEmpty(List<String> uuids) {
  if (uuids.isEmpty) return true;
  for (var uuid in uuids) {
    if (uuid.isNotEmpty) return false;
  }
  return true;
}

List<Guid> stringToGuidList(List<String> guids) {
  List<Guid> guidList = [];
  for (var item in guids) {
    guidList.add(Guid(item));
  }

  return guidList;
}

String appendAdvUuidForIos(String advUuid) {
  if (advUuid.length != 4 && advUuid.length != 8) return advUuid;
  if (advUuid.length == 4) {
    advUuid = '0000$advUuid-0000-1000-8000-00805f9b34fb';
  } else if (advUuid.length == 8) {
    advUuid = '$advUuid-0000-1000-8000-00805f9b34fb';
  }
  return advUuid.toLowerCase();
}

int getAesIndex(String deviceName, List<String> prefixList,
    String scanFilterServiceUuid, List<String> scanFilterUuidAESList) {
  int aesKeyIndex = deviceName.getPrefixIndex(prefixList);
  if (aesKeyIndex < 0) {
    aesKeyIndex =
        scanFilterServiceUuid.getScanFilterUuidIndex(scanFilterUuidAESList);
  }

  return aesKeyIndex;
}
