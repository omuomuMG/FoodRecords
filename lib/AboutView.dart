import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_records/EditView.dart';
import 'package:food_records/HomeListView.dart';
import 'package:food_records/sqlLite.dart';

class AboutView extends StatefulWidget {
  final memoList;
  final index;
  final selectedvalue;
  AboutView(
      {required this.memoList,
      required this.index,
      required this.selectedvalue});
  @override
  AboutViewState createState() => AboutViewState();
}

class AboutViewState extends State<AboutView> {
  @override
  Widget build(BuildContext context) {
    var memoList = widget.memoList;
    final index = widget.index;
    var selectedvalue = widget.selectedvalue;
    final upDateController = TextEditingController();

    final memoListId = memoList[index].id;

    return Scaffold(
        appBar: AppBar(
          title: Text('List Test'),
        ),
        body: ListView(
          children: [
            GestureDetector(
              onTap: () async {
                await Memo.deleteMemo(memoList[index].id);
                final List<Memo> memos = await Memo.getMemos();
                setState(() {
                  memoList = memos;
                });
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MySqlPage()),
                );
              },
              child: Card(
                child: Container(
                  height: 60,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Row(
                      children: [
                        Icon(Icons.delete_forever),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            "削除する",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Card(
              child: Container(
                height: 60,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Row(
                    children: [
                      Text(
                        "作成日：${memoList[index].nowDate}",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Card(
              child: Container(
                height: 60,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Row(
                    children: [
                      Text(
                        "ID：${memoList[index].id}",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () async {
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
                                Container(
                                  child: Flexible(
                                    flex: 3,
                                    child:
                                        TextField(controller: upDateController),
                                  ),
                                ),
                                RaisedButton(
                                  child: Text('更新'),
                                  onPressed: () async {
                                    Memo updateMemo = Memo(
                                        id: selectedvalue,
                                        text: upDateController.text,
                                        subtext: '',
                                        nowDate: '');
                                    await Memo.updateMemo(updateMemo);
                                    final List<Memo> memos =
                                        await Memo.getMemos();
                                    super.setState(() {
                                      memoList = memos;
                                    });
                                    upDateController.clear();
                                    Navigator.pop(context);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => MySqlPage()),
                                    );
                                  },
                                ),
                              ],
                            );
                          },
                        ),
                      );
                    });
              },
              child: Card(
                child: Container(
                  height: 60,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Row(
                      children: [
                        Icon(Icons.delete_forever),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            "編集する",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        )
        // body: ListView.builder(
        //   itemBuilder: (BuildContext context, index) {
        //     return GestureDetector(
        //       onTap: () async {
        //         await Memo.deleteMemo(memoList[index].id);
        //         final List<Memo> memos = await Memo.getMemos();
        //         setState(() {
        //           memoList = memos;
        //         });
        //         Navigator.push(
        //           context,
        //           MaterialPageRoute(builder: (context) => MySqlPage()),
        //         );
        //       },
        //       child: Card(
        //           child: Row(
        //         children: [
        //           Icon(Icons.delete_forever),
        //           Text('編集'),
        //         ],
        //       )),
        //     );
        //   },
        //   itemCount: memoList.length,
        // ),
        );
  }
}
