// Base
import 'history_page_vm_base.dart';
// Extention
import 'package:ramyeon_counter/utility/extension_methods/em_datetime.dart';
// Package
import 'package:darq/darq.dart';
import 'package:flutter/material.dart';
// Model
import 'package:ramyeon_counter/model/stock.dart';
import 'package:ramyeon_counter/model/repository/stock_repository.dart';
// ViewModel
import 'price_range_selecter_vm.dart';

class HistoryPricePageViewModel extends HistoryPageViewModelBase {
  HistoryPricePageViewModel(int? brandId) {
    final repository = StockRepository();
    final query = switch (brandId) {
      int id => repository.readByBrandId(id),
      _ => repository.readAll(),
    };
    query.then((result) => source = result);
  }

  /* ViewSource */
  List<Stock>? get source => _source;
  List<Stock>? _source; // late initialize
  set source(List<Stock> value) {
    if (_source == null) {
      if (value.isNotEmpty) {
        _source = _view = value;
        dateRange = dateRangeDefault = DateTimeRange(
          start: value.orderBy((x) => x.purchaseDate).first.purchaseDate,
          end: DateTime.now(),
        );
        _priceRange.maxPrice = value.orderBy((x) => x.price).first.price;
        notifyListeners();
      }
      // value.isEmpty
      else {
        _source = _view = value;
        notifyListeners();
      }
    }
  }

  /// 表示内容
  List<Stock>? get view => _view;
  List<Stock>? _view;

  /* SearchSheet */
  PriceRangeSelecterViewModel get priceRange => _priceRange;
  final PriceRangeSelecterViewModel _priceRange = .new();

  /* Command */
  /// 検索
  @override
  void search() {
    _view = _source!
        .where((x) => priceRange.priceRange.start <= x.price)
        .where((x) => x.price <= priceRange.priceRange.end)
        .where((x) => dateRange.start.isBeforeAndSame(x.purchaseDate))
        .where((x) => dateRange.end.isAfterAndSame(x.purchaseDate))
        .toList();
    notifyListeners();
  }

  /// リセット
  @override
  void reset() {
    _view = _source!;
    priceRange.priceRangeReset();
    resetDateRange();
    notifyListeners();
  }

  /* Override */
  @override
  bool get isSourceEmpty => _source!.isEmpty;

  @override
  bool get isSourceNotNull => _source != null;

  @override
  bool get isSourceNull => _source == null;

  @override
  int get listviewCount => view != null ? view!.length : 0;
}
