import 'package:flutter/material.dart';
import 'package:food_records/AboutView.dart';
import 'package:food_records/sqlLite.dart';
import 'dart:async';
import 'package:uuid/uuid.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo SQL',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MySqlPage(),
    );
  }
}

class MySqlPage extends StatefulWidget {
  @override
  _MySqlPageState createState() => _MySqlPageState();
}

class _MySqlPageState extends State<MySqlPage> {
  List<Memo> _memoList = [];
  final myController = TextEditingController();
  final upDateController = TextEditingController();
  final subDataController = TextEditingController();
  var _selectedvalue;

  Future<void> initializeDemo() async {
    _memoList = await Memo.getMemos();
  }

  @override
  void dispose() {
    myController.dispose();
    subDataController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('メモアプリ'),
      ),
      body: Container(
        padding: EdgeInsets.all(32),
        child: FutureBuilder(
          future: initializeDemo(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView.builder(
              itemCount: _memoList.length,
              itemBuilder: (context, index) {
                return Card(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'ID ${_memoList[index].id}',
                            style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold),
                          ),
                          Container(
                            child: Row(
                              children: [
                                RaisedButton(
                                  // onPressed: () async {
                                  //   await Memo.deleteMemo(_memoList[index].id);
                                  //   final List<Memo> memos =
                                  //       await Memo.getMemos();
                                  //   setState(() {
                                  //     _memoList = memos;
                                  //   });
                                  // },
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => AboutView()),
                                    );
                                  },
                                  child: Icon(
                                    Icons.arrow_forward_ios,
                                    size: 20,
                                  ),
                                  shape: CircleBorder(),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Text('${_memoList[index].text}'),
                      Text("${_memoList[index].subtext}")
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: Column(
        verticalDirection: VerticalDirection.up,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                        title: Text("新規メモ作成"),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text('料理名'),
                            TextField(controller: myController),
                            Text('備考欄'),
                            TextField(controller: subDataController),
                            RaisedButton(
                              child: Text('保存'),
                              onPressed: () async {
                                Memo _memo = Memo(
                                    text: myController.text,
                                    id: Uuid().hashCode,
                                    subtext: subDataController.text);
                                await Memo.insertMemo(_memo);
                                final List<Memo> memos = await Memo.getMemos();
                                setState(() {
                                  _memoList = memos;
                                  _selectedvalue = null;
                                });
                                myController.clear();
                                subDataController.clear();
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        ),
                      ));
            },
          ),
          SizedBox(height: 20),
          // FloatingActionButton(
          //     child: Icon(Icons.update),
          //     backgroundColor: Colors.amberAccent,
          //     onPressed: () async {
          //       await showDialog(
          //           context: context,
          //           builder: (BuildContext context) {
          //             return AlertDialog(
          //               content: StatefulBuilder(
          //                 builder:
          //                     (BuildContext context, StateSetter setState) {
          //                   return Column(
          //                     mainAxisSize: MainAxisSize.min,
          //                     children: <Widget>[
          //                       Text('IDを選択して更新してね'),
          //                       Row(
          //                         children: <Widget>[
          //                           Flexible(
          //                             flex: 1,
          //                             child: DropdownButton(
          //                               hint: Text("ID"),
          //                               value: _selectedvalue,
          //                               onChanged: (newValue) {
          //                                 setState(() {
          //                                   _selectedvalue = newValue;
          //                                   print(newValue);
          //                                 });
          //                               },
          //                               items: _memoList.map((entry) {
          //                                 return DropdownMenuItem(
          //                                     value: entry.id,
          //                                     child: Text(entry.id.toString()));
          //                               }).toList(),
          //                             ),
          //                           ),
          //                           Flexible(
          //                             flex: 3,
          //                             child: TextField(
          //                                 controller: upDateController),
          //                           ),
          //                         ],
          //                       ),
          //                       RaisedButton(
          //                         child: Text('更新'),
          //                         onPressed: () async {
          //                           Memo updateMemo = Memo(
          //                               id: _selectedvalue,
          //                               text: upDateController.text);
          //                           await Memo.updateMemo(updateMemo);
          //                           final List<Memo> memos =
          //                               await Memo.getMemos();
          //                           super.setState(() {
          //                             _memoList = memos;
          //                           });
          //                           upDateController.clear();
          //                           Navigator.pop(context);
          //                         },
          //                       ),
          //                     ],
          //                   );
          //                 },
          //               ),
          //             );
          //           });
          //     }),
        ],
      ),
    );
  }
}
