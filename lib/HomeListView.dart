import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:food_records/AboutView.dart';
import 'package:food_records/sqlLite.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
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
  List<Memo> memoList = [];
  final myController = TextEditingController();
  final subDataController = TextEditingController();
  final upDateController = TextEditingController();
  final upDateSubController = TextEditingController();

  var selectedvalue;

  // 選択した日時を格納する変数
  var _mydatetime = new DateTime.now();

  var formatter = new DateFormat('yyyy/MM/dd');

  String getTodayDate() {
    initializeDateFormatting('ja');
    return DateFormat.yMMMd('ja').format(DateTime.now()).toString();
  }

  Future<void> initializeDemo() async {
    memoList = await Memo.getMemos();
  }

  @override
  void dispose() {
    myController.dispose();
    subDataController.dispose();
    super.dispose();
  }

  bool dateDone = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('メモアプリ'),
        backgroundColor: Colors.white,
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: FutureBuilder(
          future: initializeDemo(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView.builder(
              itemCount: memoList.length,
              itemBuilder: (context, index) {
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'ID ${memoList[index].id}',
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 2.0, right: 2),
                              child: SizedBox(
                                height: 20,
                                child: ElevatedButton(
                                  child: const Icon(
                                    Icons.arrow_forward_ios,
                                    size: 15,
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.blueGrey,
                                    onPrimary: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => AboutView(
                                                memoList: memoList,
                                                index: index,
                                                selectedvalue:
                                                    memoList[index].id,
                                                // myController: myController.text,
                                                // subDataController:
                                                //     subDataController.text,
                                              )),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),

                        Text(
                          '${memoList[index].text}',
                          style: TextStyle(fontSize: 16),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(bottom: 6.0),
                          child: Text(
                            "${memoList[index].subtext}",
                            style: TextStyle(),
                          ),
                        ),
                        Divider(
                          height: 1,
                          color: Colors.grey,
                        ),
                        // Text(
                        //   "作成日 ${memoList[index].createdDate}",
                        //   style: TextStyle(color: Colors.grey[600]),
                        // ),
                        Text("食べた日: ${memoList[index].eatDate}",
                            style: TextStyle(
                              color: Colors.grey[600],
                            )),
                      ],
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
                        title: Text("記録する"),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(bottom: 6.0),
                              child: Text(
                                '料理名',
                              ),
                            ),
                            TextField(
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.blue,
                                  ),
                                ),
                              ),
                              controller: myController,
                              maxLines: 5,
                              minLines: 3,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 8.0, bottom: 6.0),
                              child: Text(
                                '備考欄',
                              ),
                            ),
                            TextField(
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.blue,
                                  ),
                                ),
                              ),
                              controller: subDataController,
                              maxLines: 5,
                              minLines: 3,
                            ),
                            GestureDetector(
                              onTap: () {
                                DatePicker.showDatePicker(context,
                                    showTitleActions: true, onChanged: (date) {
                                  print('change $date');
                                },
                                    // onConfirm内の処理はDatepickerで選択完了後に呼び出される
                                    onConfirm: (date) {
                                  print("Done $date");
                                  setState(() {
                                    _mydatetime = date;
                                    dateDone = true;
                                  });
                                },
                                    currentTime: DateTime.now(),
                                    locale: LocaleType.jp);
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(top: 10, bottom: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.calendar_today,
                                      color: Colors.redAccent,
                                    ),
                                    Text(
                                      "食べた日を入力する",
                                      style: TextStyle(color: Colors.grey[800]),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            RaisedButton(
                              child: Text('保存'),
                              onPressed: () async {
                                Memo _memo = Memo(
                                  text: myController.text,
                                  id: Uuid().hashCode,
                                  subtext: subDataController.text,
                                  createdDate: getTodayDate(),
                                  eatDate: formatter.format(_mydatetime),
                                  updateDate: "未編集",
                                );
                                await Memo.insertMemo(_memo);
                                final List<Memo> memos = await Memo.getMemos();
                                setState(() {
                                  memoList = memos;
                                  selectedvalue = selectedvalue;
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
        ],
      ),
    );
  }
}
