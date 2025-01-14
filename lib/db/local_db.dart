import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart'
    if (dart.library.html) 'package:sqflite/sqflite_common_ffi.dart';

import '../ble/log.dart';
import '../blelib.dart';

class BleLocalDB {
  static int currentVersion = 3;
  BleLocalDB._();

  static Future<void> upgradeDatabase(
      Database db, int oldVersion, int newVersion) async {
    if (oldVersion < currentVersion) {
      // 在旧版本小于2时执行升级脚本
      await db.execute(
          'ALTER TABLE history ADD COLUMN connect_time INTEGER DEFAULT 0');
    }
  }

  static Future<BleLocalDB> create() async {
    // Call the private constructor
    var db = BleLocalDB._();

    try {
      // open the database
      var databasesPath = await getDatabasesPath();
      String path = join(databasesPath, 'eiker_ble.db');
      db.database = await openDatabase(path, version: currentVersion,
          onUpgrade: (db, oldVersion, newVersion) async {
        await upgradeDatabase(db, oldVersion, newVersion);
      }, onCreate: (Database db, int version) async {
        // When creating the db, create the table

        await db.execute(
            'CREATE TABLE history (mac_id TEXT, name TEXT, update_time TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,connect_time INTEGER, UNIQUE(mac_id))');
      });
    } catch (e) {
      ekLog('本地create出现异常$e');
    }
    return db;
  }

  late Database database;

  close() {
    database.close();
  }

  clearLocalBindDevice() async {
    try {
      await database.rawDelete('DELETE FROM history');
    } catch (e) {
      ekLog('本地clearLocalBindDevice出现异常$e');
    }
  }

  Future<List<Map>> getLocalBindDeviceList() async {
    try {
      List<Map> result = await database
          .rawQuery('SELECT * FROM history ORDER BY update_time DESC');
      return result;
    } catch (e) {
      ekLog('本地getLocalBindDeviceList出现异常$e');
      return [];
    }
  }

  removeBindDevice(String macId) async {
    try {
      await database.execute('DELETE FROM history where mac_id=\'$macId\'');
    } catch (e) {
      ekLog('本地删除设备出现异常$e');
    }
  }

  insertOrUpdateBindDevice(BleDevice bindDevice) async {
    try {
      if (bindDevice.device == null) return;

      int historyCount = Config.gHistoryCount - 1;

      await database.execute(
          'DELETE FROM history where mac_id in (SELECT mac_id FROM history order by update_time desc limit $historyCount,100000)');

      var macId = bindDevice.deviceId;
      var name = bindDevice.localName;
      var connectTime = bindDevice.connectTimestamp;
      await database.execute(
          'INSERT OR REPLACE INTO history(mac_id, name, connect_time) VALUES(\'$macId\', \'$name\', $connectTime)');
    } catch (e) {
      ekLog('本地insertOrUpdateBindDevice出现异常$e');
    }
  }
}
