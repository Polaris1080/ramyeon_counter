import 'dart:async';
//import 'package:darq/darq.dart';
import 'package:darq/darq.dart';
import 'package:flutter/material.dart';
import 'package:ramyeon_counter/model/repository/ramyeon_repository.dart';
import 'package:ramyeon_counter/model/stock.dart';
import 'package:ramyeon_counter/model/repository/stock_repository.dart';
import 'package:ramyeon_counter/page/stock/stock_page.dart';

class StockPageViewModel extends ChangeNotifier {
  int count = 0;

  StockPageViewModel(this.brandId);

  final int? brandId;

  List<StockPostitViewModel>? post;
  Future<List<StockPostitViewModel>?> get postit async {
    if (post is List<StockPostitViewModel>) {
      return post;
    } else {
      await reload();
      return post;
    }
  }

  void reset() {
    post = null;
    notifyListeners();
  }

  Future<void> reload() async {
    final model1 = StockRepository();
    final model2 = RamyeonRepository();
    final (result1, result2) = await (
      brandId != null ? model1.readByBrandId(brandId!) : model1.readAll(),
      model2.readAll(),
    ).wait;
    stock = result1.where((x) => !(x.ate)).toList();
    count = stock!.length;
    _brand = result2.toMap((x) => MapEntry(x.id, x.brand));
    _color = result2.toMap((x) => MapEntry(x.id, x.packageColor));
    post = stock!.select((s, _) => StockPostitViewModel(s)).toList();
    notifyListeners();
  }

  List<Stock>? stock;

  Map<int, String>? get brand => _brand;
  Map<int, String>? _brand;

  Map<int, int?>? get color => _color;
  Map<int, int?>? _color;

  ///（削除）選択モード
  bool get isSelectMode => _isSelectMode;
  bool _isSelectMode = false;
  set isSelectMode(bool value) {
    if (isSelectMode != value) {
      // true->false
      if (value == false && post != null) {
        for (var element in post!) {
          element.selected = false;
        }
      }
      _isSelectMode = value;
      notifyListeners();
    }
  }
}
