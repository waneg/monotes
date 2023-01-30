import 'package:common_utils/common_utils.dart';
import 'package:sqflite/sqflite.dart';

class SqlManager {
  // 数据库版本
  static const _VERSION = 1;

  // 数据库命名
  static const _DB_NAME = "root.db";

  // 数据库对象
  static Database? _database;

  // 初始化数据库对象
  static init() async {
    // 生成数据库在本地存储中的位置
    String dbPath = "${await getDatabasesPath()}/$_DB_NAME";

    _database = await openDatabase(dbPath, version: _VERSION);
  }

  // 获取当前数据库对象，第一次获取没有创建则创建
  static Future<Database> getCurrentDataBase() async {
    if (_database == null) {
      await init();
    }

    return _database!;
  }

  // 判断表是否存在
  static Future<bool> isTableExists(String tableName) async {
    await getCurrentDataBase();
    var res = await _database?.rawQuery(
        "select * from sqlite_master where type = 'table' ans name = '$tableName'");

    return !ObjectUtil.isEmpty(res);
  }

  // 关闭数据库
  static void close() {
    _database?.close();
    _database = null;
  }
}
