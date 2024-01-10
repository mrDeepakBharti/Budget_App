import 'dart:io' as io;

import 'package:flutter_application_budget_app_using_sqflite/UserModel/user.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static Database? _db;

  Future<Database?> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDatabase();
    return _db;
  }

  Future<Database> initDatabase() async {
    io.Directory docunmentDirectory = await getApplicationCacheDirectory();
    String path = join(docunmentDirectory.path, "user.db");
    var db = openDatabase(path, version: 1, onCreate: OnCreate);
    return db;
  }

  OnCreate(Database db, int version) async {
    return db.execute(
        '''CREATE TABLE user (id INTEGER PRIMARY KEY, title TEXT, amount REAL, date TEXT)''');
  }

  Future<UserModel> insertData(UserModel userModel) async {
    var dbClient = await db;
    dbClient!.insert('user', userModel.tomap());
    return userModel;
  }

  Future<List<UserModel>> getData() async {
    var dbClient = await db;
    List<Map<String, dynamic>> result = await dbClient!.query("user");

    return result.map((e) => UserModel.formap(e)).toList();
  }

  Future<int> deleteData(int id) async {
    var dbClient = await db;
    return dbClient!.delete("user", where: "id=?", whereArgs: [id]);
  }

  Future<int> updateData(UserModel userModel) async {
    var dbClient = await db;
    return dbClient!.update("user", userModel.tomap(),
        where: "id=?", whereArgs: [userModel.id]);
  }
}
