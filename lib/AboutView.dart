import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AboutView extends StatefulWidget {
  @override
  _AboutViewState createState() => _AboutViewState();
}

class _AboutViewState extends State<AboutView> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('ListView'),
        ),
        body: ListView(children: [
          _menuItem("メニュー1", Icon(Icons.settings)),
          _menuItem("メニュー2", Icon(Icons.map)),
          _menuItem("メニュー3", Icon(Icons.room)),
        ]),
      ),
    );
  }

  Widget _menuItem(String title, Icon icon) {
    return Container(
      decoration: new BoxDecoration(
          border:
              new Border(bottom: BorderSide(width: 1.0, color: Colors.grey))),
      child: ListTile(
        leading: icon,
        title: Text(
          title,
          style: TextStyle(color: Colors.black, fontSize: 18.0),
        ),
        onTap: () {
          print("onTap called.");
        }, // タップ
        onLongPress: () {
          print("onLongPress called.");
        }, // 長押し
      ),
    );
  }
}
