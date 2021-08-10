import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_records/add.dart';
import 'package:food_records/sqlLite.dart';

class AboutView extends StatefulWidget {
  final memoList;
  final index;
  AboutView({required this.memoList, required this.index});
  @override
  AboutViewState createState() => AboutViewState();
}

class AboutViewState extends State<AboutView> {
  @override
  Widget build(BuildContext context) {
    var memoList = widget.memoList;
    final index = widget.index;

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
                  child: Row(
                    children: [
                      Text(
                        "削除する",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
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
