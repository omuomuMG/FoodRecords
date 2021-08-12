import 'package:flutter/material.dart';
import 'package:food_records/sqlLite.dart';

class EditView extends StatefulWidget {
  final selectedvalue;
  final memoList;
  final upDateController;
  final memoListId;

  EditView(
      {required this.selectedvalue,
      required this.memoList,
      required this.upDateController,
      required this.memoListId});
  @override
  _EditViewState createState() => _EditViewState();
}

class _EditViewState extends State<EditView> {
  @override
  Widget build(BuildContext context) {
    var memoList = widget.memoList;
    final upDateController = widget.upDateController;
    final selectedvalue = widget.selectedvalue;

    return Scaffold(
      body: Column(
        children: [
          Container(
            child: Column(
              children: [
                GestureDetector(),
              ],
            ),
          ),
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
