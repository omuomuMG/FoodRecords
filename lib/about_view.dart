import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_records/home_list_view.dart';
import 'package:food_records/sql_lite.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class AboutView extends StatefulWidget {
  final memoList;
  final index;
  final selectedvalue;
  const AboutView({
    required this.memoList,
    required this.index,
    required this.selectedvalue,
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
                            const Text('食べ物'),
                            // ignore: avoid_unnecessary_containers
                            Container(
                              child: Flexible(
                                flex: 3,
                                child: TextField(
                                    decoration: const InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.blue,
                                        ),
                                      ),
                                    ),
                                    maxLines: 5,
                                    minLines: 3,
                                    controller: upDateController),
                              ),
                            ),

                            ElevatedButton(
                              onPressed: () async {
                                Memo updateMemo = Memo(
                                    id: selectedvalue,
                                    text: upDateController.text,
                                    subtext: memoList[index].subtext,
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
                                // ignore: use_build_context_synchronously
                                Navigator.pop(context);
                                // ignore: use_build_context_synchronously
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MySqlPage()),
                                );
                              },
                              child: const Text('更新'),
                            )
                          ],
                        );
                      },
                    ),
                  );
                });
          },
          child: Card(
            color: Colors.blue,
            // ignore: sized_box_for_whitespace
            child: Container(
              height: 60,
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Row(
                  children: <Widget>[
                    const Icon(Icons.edit),
                    const Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Text(
                        "食べ物を編集する",
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
            await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    content: StatefulBuilder(
                      builder: (BuildContext context, StateSetter setState) {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            const Text('備考欄'),
                            // ignore: avoid_unnecessary_containers
                            Container(
                              child: Flexible(
                                flex: 3,
                                child: TextField(
                                    decoration: const InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.blue,
                                        ),
                                      ),
                                    ),
                                    maxLines: 5,
                                    minLines: 3,
                                    controller: upDateSubController),
                              ),
                            ),
                            ElevatedButton(
                                onPressed: () async {
                                  Memo updateMemo = Memo(
                                      id: selectedvalue,
                                      text: memoList[index].text,
                                      subtext: upDateSubController.text,
                                      createdDate: memoList[index].createdDate,
                                      eatDate: memoList[index].eatDate,
                                      updateDate: getUpdateDate());
                                  await Memo.updateMemo(updateMemo);
                                  final List<Memo> memos =
                                      await Memo.getMemos();
                                  super.setState(() {
                                    memoList = memos;
                                  });
                                  upDateController.clear();
                                  upDateSubController.clear();
                                  // ignore: use_build_context_synchronously
                                  Navigator.pop(context);
                                  // ignore: use_build_context_synchronously
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MySqlPage()),
                                  );
                                },
                                child: const Text('更新')),
                          ],
                        );
                      },
                    ),
                  );
                });
          },
          child: Card(
            color: Colors.blue,
            // ignore: sized_box_for_whitespace
            child: Container(
              height: 60,
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Row(
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    const Icon(Icons.edit),
                    const Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Text(
                        "備考欄を編集する",
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
            await Memo.deleteMemo(memoList[index].id.hashCode);
            final List<Memo> memos = await Memo.getMemos();
            setState(() {
              memoList = memos;
            });
            // ignore: use_build_context_synchronously
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MySqlPage()),
            );
          },
          child: Card(
            color: Colors.redAccent,
            // ignore: sized_box_for_whitespace
            child: Container(
              height: 60,
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Row(
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    const Icon(Icons.delete_forever),
                    const Padding(
                      padding: EdgeInsets.only(left: 8.0),
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
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        ),
        Card(
          // ignore: sized_box_for_whitespace
          child: Container(
            height: 60,
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Row(
                children: [
                  Text(
                    "ID：${memoList[index].id}",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        ),
        Card(
          // ignore: sized_box_for_whitespace
          child: Container(
            height: 60,
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Row(
                children: [
                  Text(
                    "更新日：${memoList[index].updateDate}",
                    style: const TextStyle(fontWeight: FontWeight.bold),
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
