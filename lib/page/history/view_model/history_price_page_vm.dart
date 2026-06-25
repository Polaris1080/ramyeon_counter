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
  HistoryPricePageViewModel(int? brandId) : _brandId = brandId;

  final int? _brandId;
  final StockRepository _repository = .new();

  /* ViewSource */
  @override
  Future loadSource() async => switch (_source) {
    List<Stock> _ => null,
    null =>
      await (switch (_brandId) {
        int id => _repository.readByBrandId(id),
        _ => _repository.readAll(),
      }).then((result) {
        _source = _view = result;
        if (result.isNotEmpty) {
          dateRange = dateRangeDefault = DateTimeRange(
            start: result.orderBy((x) => x.purchaseDate).first.purchaseDate,
            end: DateTime.now(),
          );
          _priceRange.maxPrice = result.orderBy((x) => x.price).first.price;
        }
        notifyListeners();
        return null;
      }),
  };
  List<Stock>? _source;

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
  bool get isSourceEmpty => _source != null ? _source!.isEmpty : false;

  @override
  bool get isSourceNotNull => _source != null;

  @override
  bool get isSourceNull => _source == null;

  @override
  int get listviewCount => view != null ? view!.length : 0;
}
