import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_records/HomeListView.dart';
import 'package:food_records/sqlLite.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class AboutView extends StatefulWidget {
  //final myController;
  //final subDataController;
  final memoList;
  final index;
  final selectedvalue;
  AboutView({
    required this.memoList,
    required this.index,
    required this.selectedvalue,
    //this.subDataController,
    //this.myController
  });
  @override
  AboutViewState createState() => AboutViewState();
}

class AboutViewState extends State<AboutView> {
  @override
  Widget build(BuildContext context) {
    String getUpdateDate() {
      initializeDateFormatting('ja');
      return DateFormat.yMMMd('ja').format(DateTime.now()).toString();
    }

    // final myController = widget.myController;
    // final subDataController = widget.subDataController;

    var memoList = widget.memoList;
    final index = widget.index;
    var selectedvalue = widget.selectedvalue;
    final upDateController = TextEditingController();
    final upDateSubController = TextEditingController();

    return Scaffold(
        body: ListView(
      children: [
        GestureDetector(
          onTap: () async {
            await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    content: StatefulBuilder(
                      builder: (BuildContext context, StateSetter setState) {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text('食べ物'),
                            Container(
                              child: Flexible(
                                flex: 3,
                                child: TextField(controller: upDateController),
                              ),
                            ),
                            Text('備考欄'),
                            Container(
                              child: Flexible(
                                flex: 3,
                                child:
                                    TextField(controller: upDateSubController),
                              ),
                            ),
                            RaisedButton(
                              child: Text('更新'),
                              onPressed: () async {
                                Memo updateMemo = Memo(
                                    id: selectedvalue,
                                    text: upDateController.text,
                                    subtext: upDateSubController.text,
                                    createdDate: memoList[index].createdDate,
                                    eatDate: memoList[index].eatDate,
                                    updateDate: getUpdateDate());
                                await Memo.updateMemo(updateMemo);
                                final List<Memo> memos = await Memo.getMemos();
                                super.setState(() {
                                  memoList = memos;
                                });
                                upDateController.clear();
                                upDateSubController.clear();
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
                    Icon(Icons.edit),
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
                    "作成日：${memoList[index].createdDate}",
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
        Card(
          child: Container(
            height: 60,
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Row(
                children: [
                  Text(
                    "更新日：${memoList[index].updateDate}",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    ));
  }
}
