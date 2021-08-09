import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:food_records/add.dart';
import 'BottomNavigationBar.dart';

void main() {
  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MySqlPage(),
    );
  }
}
