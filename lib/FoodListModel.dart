import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final foodsListProvider = ChangeNotifierProvider(
  (ref) => FoodsListProvider(),
);

class FoodsListProvider extends ChangeNotifier {}
