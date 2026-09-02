// Package
import 'package:flutter/material.dart';
import 'package:ramyeon_counter/models/model/ramyeon/repository/ramyeon_repository.dart';
import 'package:ramyeon_counter/models/model/ramyeon/repository/rating_repository.dart';
import 'package:ramyeon_counter/models/model/ramyeon/repository/stock_repository.dart';
import 'package:ramyeon_counter/utility/annotations/viewmodel_annotation.dart';

class RamyeonDataViewerViewModel({required final int ramyeonId})
    extends ChangeNotifier {
  /// Show brand name.
  @OneWay()
  String get brand => _brand;
  String _brand = "";

  /// Rating average.
  @OneWay()
  double get rate => _rate;
  double _rate = _defaultRate;
  static const _defaultRate = 0.0;

  /// Price average.
  @OneWay()
  String get price => '価格：${_price != null ? _price!.round() : "-"}円';
  double? _price;

  /* Command */
  Future load() async {
    _brand = (await RamyeonRepository().read(ramyeonId)).brand;
    _rate = (await RatingRepository().averageByBrandId(ramyeonId));
    notifyListeners();

    final (price, date) = await StockRepository().avgPriceByBrandId(ramyeonId);
    print(await StockRepository().avgPriceByBrandId(ramyeonId));
    _price = price;
  }
}
// 1:今から一年
// 2:一年～三年の始点から一年
