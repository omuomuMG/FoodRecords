import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class PostData {
  late final String food;
  // late final String sentence;
  late final int id;
  // late final int eatTimeStamp;
  // late final int postTimeStamp;
  // late final int updateTimeStamp;

  PostData({
    required this.food,
    // required this.sentence,
    required this.id,
    // required this.eatTimeStamp,
    // required this.postTimeStamp,
    // required this.updateTimeStamp
  });

  Map<String, dynamic> toMap() {
    return {
      'food': food,
      // 'sentence': sentence,
      "id": id,
      // 'eatTimeStamp': eatTimeStamp,
      // "postTimeStamp": postTimeStamp,
      // "updateTimeStamp": updateTimeStamp
    };
  }

  @override
  String toString() {
    return 'PostData{food: $food,}';
    //'sentence: $sentence,id: $id,eatTimeStamp: $eatTimeStamp,postTimeStamp: $postTimeStamp,updateTimeStamp: $updateTimeStamp
  }

  static Future<List<PostData>> getMemos() async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query('postData');
    return List.generate(maps.length, (i) {
      return PostData(
        food: maps[i]['food'],
        // sentence: maps[i]['sentence'],
        id: maps[i]['id'],
        // eatTimeStamp: maps[i]['eatTimeStamp'],
        // postTimeStamp: maps[i]['postTimeStamp'],
        // updateTimeStamp: maps[i]['updateTimeStamp'],
      );
    });
  }

//データベースの作成
  static Future<Database> get database async {
    final Future<Database> _database = openDatabase(
      join(await getDatabasesPath(), 'postData.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE postData(food TEXT, id INTEGER PRIMARY KEY AUTOINCREMENT)",
        );
      },
      version: 1,
    );
    return _database;
  }

  //データの作成(insert)
  static Future<void> insertMemo(PostData postData) async {
    final Database db = await database;
    await db.insert(
      'postData',
      postData.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  //更新
  static Future<void> updateMemo(PostData postData) async {
    final db = await database;
    await db.update(
      'postData',
      postData.toMap(),
      where: "id = ?",
      whereArgs: [postData.id],
      conflictAlgorithm: ConflictAlgorithm.fail,
    );
  }

  //削除
  static Future<void> deleteMemo(int id) async {
    final db = await database;
    await db.delete(
      'postData',
      where: "id = ?",
      whereArgs: [id],
    );
  }
}
