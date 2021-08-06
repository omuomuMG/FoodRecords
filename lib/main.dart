import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
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
      title: 'Riverpod Sample',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: BottomNavigationBarView(),
    );
  }
}
