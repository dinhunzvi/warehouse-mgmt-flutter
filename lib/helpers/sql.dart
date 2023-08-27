import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sql.dart';

class SQLHelper {

  //
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""CREATE TABLE items(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        name TEXT,
        quantity DOUBLE,
        createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
      )
      """);
  }

  //
  static Future<sql.Database> db() async {
    return sql.openDatabase('varichem.db', version: 1,
    onCreate: (sql.Database database, int version) async {
      await createTables(database);
    });
  }

  // create a new item
  static Future<int> createItem(String name, Double quantity) async {
    final db = await SQLHelper.db();

    final data = {'name': name, 'quantity': quantity};

    return db.insert('items', data,
    conflictAlgorithm: ConflictAlgorithm.replace);

  }

  // get all items
  static Future<List<Map<String, dynamic>>> getItems() async {
    final db = await SQLHelper.db();

    return db.query('items', orderBy: 'id');

  }

  // get one item
  static Future<List<Map<String, dynamic>>> getItem(int id) async {
    final db = await SQLHelper.db();

    return db.query('items', where: "id = ?", whereArgs: [id], limit: 1);

  }

  // update an item
  static Future<int> updateItem(int id, String name, int quantity) async {
    final db = await SQLHelper.db();

    final data = {
      'name': name,
      'quantity': quantity,
      'createdAt': DateTime.now().toString()
    };

    return await db.update('items', data, where: "id = ?", whereArgs: [id]);
    
  }

  // delete an item
  static Future<void> deleteItem(int id) async {
    final db = await SQLHelper.db();
    
    try {
      await db.delete('items', where: "id = ?", whereArgs: [id]);
    } catch(err) {
      debugPrint("Error printing item $err, please try again");
    }
  }

}