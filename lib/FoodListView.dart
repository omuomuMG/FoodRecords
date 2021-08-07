import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_records/FoodListModel.dart';

class FoodList extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final _provider = watch(foodsListProvider);
    return Scaffold(
      body: Card(
        elevation: 2,
        child: ListView(
          children: [Text("a")], //ここにデータを表示させる
        ),
      ),
    );
  }
}
