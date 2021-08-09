import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Memo {
  final int id;
  final String text;
  final String subtext;

  Memo({required this.id, required this.text, required this.subtext});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'text': text,
      "subText": subtext,
    };
  }

  @override
  String toString() {
    return 'Memo{id: $id, text: $text, subtext: $subtext}';
  }

  static Future<Database> get database async {
    final Future<Database> _database = openDatabase(
      join(await getDatabasesPath(), 'mem_database.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE memo(id INTEGER PRIMARY KEY AUTOINCREMENT, text TEXT, subtext TEXT)",
        );
      },
      version: 2,
    );
    return _database;
  }

  static Future<void> insertMemo(Memo memo) async {
    final Database db = await database;
    await db.insert(
      'memo',
      memo.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<Memo>> getMemos() async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query('memo');
    return List.generate(maps.length, (i) {
      return Memo(
        id: maps[i]['id'],
        text: maps[i]['text'],
        subtext: maps[i]['subtext'],
      );
    });
  }

  static Future<void> updateMemo(Memo memo) async {
    final db = await database;
    await db.update(
      'memo',
      memo.toMap(),
      where: "id = ?",
      whereArgs: [memo.id],
      conflictAlgorithm: ConflictAlgorithm.fail,
    );
  }

  static Future<void> deleteMemo(int id) async {
    final db = await database;
    await db.delete(
      'memo',
      where: "id = ?",
      whereArgs: [id],
    );
  }
}
