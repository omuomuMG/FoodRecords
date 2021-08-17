import 'package:flutter/material.dart';
import 'package:food_records/home_list_view.dart';

void main() {
  runApp(
    MyApp(),
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
