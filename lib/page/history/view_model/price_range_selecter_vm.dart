// Package
import 'dart:math';
import 'package:flutter/material.dart';

class PriceRangeSelecterViewModel extends ChangeNotifier {
  static const defaultMaxPrice = 500;

  RangeValues get priceRange => _priceRange;
  RangeValues _priceRange = .new(0, defaultMaxPrice.toDouble());

  /// 最高値
  int get maxPrice => _maxPrice;
  int _maxPrice = defaultMaxPrice;
  set maxPrice(int value) {
    _maxPrice = value = min(value, defaultMaxPrice);
    _priceRange = .new(0, maxRange);
    notifyListeners();
  }

  /// 分割数
  int get divisions => (maxPrice / 10).ceil();

  /// 表示
  RangeLabels get labels => RangeLabels(
    priceRange.start.round().toString(),
    priceRange.end.round().toString(),
  );

  /// 上限
  double get maxRange => divisions * 10;

  /* Command */
  void priceRangeChanged(RangeValues value) {
    _priceRange = value;
    notifyListeners();
  }

  void priceRangeReset() => priceRangeChanged(RangeValues(0, maxRange));
}
