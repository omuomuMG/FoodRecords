import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_records/FoodListModel.dart';

class FoodList extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final _provider = watch(foodsListProvider);
    return Scaffold(
      body: Card(
        child: ListView(
          children: [Text("aa")], //ここにデータを表示させる
        ),
      ),
    );
  }
}
