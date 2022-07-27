// ignore: depend_on_referenced_packages
// ignore_for_file: avoid_print, depend_on_referenced_packages, duplicate_ignore

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqlDb {
  static Database? _db;

  /// اتحقق من انشاء الداتا بيز
  Future<Database?> get db async {
    if (_db == null) {
      _db = await intialDb();
      return _db;
    } else {
      return _db;
    }
  }

  intialDb() async {
    String databasepath = await getDatabasesPath();
    String path = join(databasepath, 'noteapp.db');
    Database mydb = await openDatabase(path,
        onCreate: _onCreate, version: 1, onUpgrade: _onUpgrade);
    // كل ما اعدل بغير الversion و بطبق ال upgrade
    return mydb;
  }

  _onUpgrade(Database db, int oldversion, intnewversion) async {
    print("Upgrad=======================");
  }

  _onCreate(Database db, int version) async {
    await db.execute('''
CREATE TABLE "notes" (
  "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
  "note" TEXT NOT NULL,
  "title" TEXT NOT NULL,
  "color" 

)
''');
//اتاكد من انشاء الدالة
    print("CREATE DATABASE AND TABLE ========================");
  }

// SELECT
  readData(String sql) async {
    Database? mydb = await db;
    List<Map> response = await mydb!.rawQuery(sql);
    return response;
  }

//INSERT
  insertData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawInsert(sql);
    return response;
  }

//UPDATE
  updateData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawUpdate(sql);
    return response;
  }

//DELETE
  deleteData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawDelete(sql);
    return response;
  }

  mydeletedatabase() async {
    String databasepath = await getDatabasesPath();
    String path = join(databasepath, 'noteapp.db');
    await deleteDatabase(path);
  }
}
