import 'dart:async';
//import 'package:darq/darq.dart';
import 'package:flutter/material.dart';
import 'package:ramyeon_counter/model/stock.dart';
import 'package:ramyeon_counter/model/repository/stock_repository.dart';

class StockPageViewModel extends ChangeNotifier {
  int count = 0;
  List<Stock>? stock;

  StockPageViewModel(int? brandId) {
    _awaitInit(brandId);
    notifyListeners();
  }

  Future<void> _awaitInit(int? brandId) async {
    final model = StockRepository();
    (brandId != null ? model.readByBrandId(brandId) : model.readAll()).then(
      (x) => {
        stock = x.where((x) => !(x.ate)).toList(),
        count = stock!.length,
        notifyListeners(),
      },
    );
  }
}
