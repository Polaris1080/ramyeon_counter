import 'dart:async';
//import 'package:darq/darq.dart';
import 'package:darq/darq.dart';
import 'package:flutter/material.dart';
import 'package:ramyeon_counter/model/repository/ramyeon_repository.dart';
import 'package:ramyeon_counter/model/stock.dart';
import 'package:ramyeon_counter/model/repository/stock_repository.dart';
import 'package:ramyeon_counter/page/stock/stock_page.dart';

class StockPageViewModel extends ChangeNotifier {
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

  Future<void> reload() async {
    final model1 = StockRepository();
    final model2 = RamyeonRepository();
    final (result1, result2) = await (
      brandId != null ? model1.readByBrandId(brandId!) : model1.readAll(),
      model2.readAll(),
    ).wait;
    stock = result1.where((x) => !(x.ate)).toList();
    _brand = result2.toMap((x) => MapEntry(x.id, x.brand));
    _color = result2.toMap(
      (x) => MapEntry(
        x.id,
        x.packageColor != null ? Color(x.packageColor!) : null,
      ),
    );
    post = stock!
        .select(
          (s, _) => StockPostitViewModel(
            s,
            brandName: brand![s.brandId]!,
            color: color![s.brandId],
          ),
        )
        .toList();
    notifyListeners();
  }

  List<Stock>? stock;

  Map<int, String>? get brand => _brand;
  Map<int, String>? _brand;

  Map<int, Color?>? get color => _color;
  Map<int, Color?>? _color;

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
      if (post != null) {
        for (var element in post!) {
          element.isSelectMode = value;
        }
      }
      _isSelectMode = value;
      notifyListeners();
    }
  }
}
