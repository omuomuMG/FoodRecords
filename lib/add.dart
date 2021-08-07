import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:food_records/sqlLite.dart';
import 'package:sqflite/sqflite.dart';

class MySqlPage extends StatefulWidget {
  @override
  _MySqlPageState createState() => _MySqlPageState();
}

class _MySqlPageState extends State<MySqlPage> {
  List<PostData> _postList = [];

  final myController = TextEditingController();
  final upDateController = TextEditingController();
  var _selectedvalue;

  Future<void> initializeDemo() async {
    _postList = await PostData.getMemos();
  }

  @override
  void dispose() {
    myController.dispose();
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
              // 非同期処理未完了 = 通信中
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView.builder(
              itemCount: _postList.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    //   leading: Text(
                    //   'ID ${_postList[index].id}',
                    //     style: TextStyle(fontWeight: FontWeight.bold),
                    //   ),
                    title: Text('${_postList[index].food}'),
                    trailing: SizedBox(
                      width: 76,
                      height: 25,
                      child: RaisedButton.icon(
                        onPressed: () async {
                          // await PostData.deleteMemo(_postList[index].id);
                          final List<PostData> memos =
                              await PostData.getMemos();
                          setState(() {
                            _postList = memos;
                          });
                        },
                        icon: Icon(
                          Icons.delete_forever,
                          color: Colors.white,
                          size: 18,
                        ),
                        label: Text(
                          '削除',
                          style: TextStyle(fontSize: 11),
                        ),
                        color: Colors.red,
                        textColor: Colors.white,
                      ),
                    ),
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
                            Text('なんでも入力してね'),
                            TextField(controller: myController),
                            RaisedButton(
                              child: Text('保存'),
                              onPressed: () async {

                                PostData _postList = PostData(food: myController.text, id: Database.id;);
                                await PostData.insertMemo(_postList);
                                final List<PostData> memos = await PostData.getMemos();

                                // await PostData.insertMemo(_postList);
                                // final List<PostData> memos =
                                //     await PostData.getMemos();
                                setState(() {
                                  _postList = memos as PostData;
                                  _selectedvalue = null;
                                });
                                myController.clear();
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        ),
                      ));
            },
          ),
          SizedBox(height: 20),
          FloatingActionButton(
              child: Icon(Icons.update),
              backgroundColor: Colors.amberAccent,
              onPressed: () async {
                await showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        content: StatefulBuilder(
                          builder:
                              (BuildContext context, StateSetter setState) {
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Text('IDを選択して更新してね'),
                                Row(
                                  children: <Widget>[
                                    Flexible(
                                      flex: 1,
                                      child: DropdownButton(
                                        hint: Text("ID"),
                                        value: _selectedvalue,
                                        onChanged: (newValue) {
                                          setState(() {
                                            _selectedvalue = newValue;
                                            print(newValue);
                                          });
                                        },
                                        items: _postList.map((entry) {
                                          return DropdownMenuItem(
                                              value: entry.id,
                                              child: Text(entry.id.toString()));
                                        }).toList(),
                                      ),
                                    ),
                                    Flexible(
                                      flex: 3,
                                      child: TextField(
                                          controller: upDateController),
                                    ),
                                  ],
                                ),
                                RaisedButton(
                                  child: Text('更新'),
                                  onPressed: () async {
                                    PostData updateMemo = PostData(
                                        id: _selectedvalue,
                                        food: upDateController.text);
                                    await PostData.updateMemo(updateMemo);
                                    final List<PostData> memos =
                                        await PostData.getMemos();
                                    super.setState(() {
                                      _postList = memos;
                                    });
                                    upDateController.clear();
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            );
                          },
                        ),
                      );
                    });
              }),
        ],
      ),
    );
  }
}
