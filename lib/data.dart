import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> getDB() async {
  var databasesPath = await getDatabasesPath();
  var path = join(databasesPath, '~www/data.db');
  var exists = await databaseExists(path);

  if (!exists) {
    try {
      await Directory(dirname(path)).create(recursive: true);
    } catch (_) {}

    var data = await rootBundle.load(join('assets', 'data.db'));
    List<int> bytes = data.buffer.asUint8List(
      data.offsetInBytes,
      data.lengthInBytes,
    );

    await File(path).writeAsBytes(bytes, flush: true);
  }

  return await openDatabase(path);
}

class PostData {
  late final String food;
  late final String sentence;
  late final int id;
  late final int eatTimeStamp;
  late final int postTimeStamp;
  late final int updateTimeStamp;

  PostData(
      {required this.id,
      required this.sentence,
      required this.eatTimeStamp,
      required this.postTimeStamp,
      required this.updateTimeStamp});
}

var postData = PostData(
    id: 0,
    sentence: 'sentence',
    eatTimeStamp: 1,
    postTimeStamp: 20,
    updateTimeStamp: 202);
