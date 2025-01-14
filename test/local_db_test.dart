import 'package:blelib/blelib.dart';
import 'package:blelib/db/local_db.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'local_db_test.mocks.dart';

@GenerateNiceMocks([MockSpec<BluetoothDevice>(), MockSpec<BleDevice>()])
void main() {
  group('local db group', () {
    late BleLocalDB db;
    setUpAll(() async {
      Config.gPrintLog = true;
      sqfliteFfiInit();
      databaseFactory = databaseFactoryFfi;
      db = await BleLocalDB.create();
    });

    tearDownAll(() async {
      await db.database.delete('history');
    });

    test('create db', () async {
      var result = await db.database.query('history');
      expect(result, []);
    });

    test('add record', () async {
      String name = 'device1';
      String id = 'id1';
      MockBluetoothDevice mockBluetoothDevice = MockBluetoothDevice();
      when(mockBluetoothDevice.remoteId).thenReturn(DeviceIdentifier(id));
      when(mockBluetoothDevice.name).thenReturn(name);
      MockBleDevice bleDevice = MockBleDevice();
      when(bleDevice.device).thenReturn(mockBluetoothDevice);
      when(bleDevice.deviceName).thenReturn(name);
      when(bleDevice.localName).thenReturn(name);
      when(bleDevice.deviceId).thenReturn(id);
      when(bleDevice.connectTimestamp).thenReturn(DateTime.now().millisecondsSinceEpoch ~/ 1000);
      await db.insertOrUpdateBindDevice(bleDevice);
      var result = await db.database
          .rawQuery('SELECT mac_id, name, connect_time FROM history');
      expect(result.length, 1);
      expect(result[0], {
        'mac_id': 'id1',
        'name': 'device1',
        'connect_time': bleDevice.connectTimestamp
      });
      expect(result[0]['mac_id'], 'id1');
      expect(result[0]['name'], 'device1');
      expect(result[0]['connect_time'], bleDevice.connectTimestamp);

      // MockBluetoothDevice mockBluetoothDevice2 = MockBluetoothDevice();
      // when(mockBluetoothDevice2.id).thenReturn(DeviceIdentifier('id2'));
      // when(mockBluetoothDevice2.name).thenReturn('device2');
      // BleDevice bleDevice2 = BleDevice.fromId('id2', 'device2');
      // bleDevice2.device = mockBluetoothDevice2;
      // bleDevice2.connectTimestamp =
      //     DateTime.now().millisecondsSinceEpoch ~/ 1000;
      // await db.insertOrUpdateBindDevice(bleDevice2);
      // var result2 = await db.database
      //     .rawQuery('SELECT mac_id, name, connect_time FROM history');
      // expect(result2.length, 2);
      // expect(result2[1], {
      //   'mac_id': 'id2',
      //   'name': 'device2',
      //   'connect_time': bleDevice2.connectTimestamp
      // });
    });

    test('getLocalBindDeviceList', () async {
      await db.getLocalBindDeviceList();
      var result = await db.database
          .rawQuery('SELECT mac_id, name, connect_time FROM history');
      expect(result[0]['mac_id'], 'id1');
    });

    test('remove', () async {
      await db.removeBindDevice('id1');
      var result =
          await db.database.rawQuery('SELECT mac_id=\'id1\' FROM history');
      expect(result, []);
    });
    test('clearLocalBindDevice', () async {
      await db.clearLocalBindDevice();
      var result = await db.database
          .rawQuery('SELECT mac_id, name, connect_time FROM history');
      expect(result.length, 0);
    });
    test('upgradeDatabase', () async {});
  });
}
