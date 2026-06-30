import 'dart:async';
//import 'package:darq/darq.dart';
import 'package:darq/darq.dart';
import 'package:flutter/material.dart';
import 'package:ramyeon_counter/model/repository/ramyeon_repository.dart';
import 'package:ramyeon_counter/model/stock.dart';
import 'package:ramyeon_counter/model/repository/stock_repository.dart';

class StockPageViewModel extends ChangeNotifier {
  int count = 0;

  Future loading(int? brandId) async {
    if (stock is List<Stock> &&
        brand is Map<int, String> &&
        color is Map<int, int>) {
      return null;
    } else {
      final model1 = StockRepository();
      final model2 = RamyeonRepository();
      final (result1, result2) = await (
        brandId != null ? model1.readByBrandId(brandId) : model1.readAll(),
        model2.readAll(),
      ).wait;
      stock = result1.where((x) => !(x.ate)).toList();
      count = stock!.length;
      _brand = result2.toMap((x) => MapEntry(x.id, x.brand));
      _color = result2.toMap((x) => MapEntry(x.id, x.packageColor));
      notifyListeners();
    }
  }

  List<Stock>? stock;

  Map<int, String>? get brand => _brand;
  Map<int, String>? _brand;

  Map<int, int?>? get color => _color;
  Map<int, int?>? _color;
}
