// Base
import 'history_page_vm_base.dart';
// Extention
import 'package:ramyeon_counter/utility/extension_methods/em_datetime.dart';
// Package
import 'package:darq/darq.dart';
import 'package:flutter/material.dart';
// Model
import 'package:ramyeon_counter/model/rating.dart';
import 'package:ramyeon_counter/model/repository/rating_repository.dart';
//  Widget
import 'package:ramyeon_counter/widget/rating/selecter/rating_range_selecter_vm.dart';

class HistoryRatingPageViewModel extends HistoryPageViewModelBase {
  HistoryRatingPageViewModel(int? brandId) : _brandId = brandId;

  final int? _brandId;
  final RatingRepository _repository = .new();

  /* ViewSource */
  @override
  Future loadSource() async => switch (_source) {
    List<Rating> _ => null,
    null =>
      await (switch (_brandId) {
        int id => _repository.readByBrandId(id),
        _ => _repository.readAll(),
      }).then((result) {
        _source = _view = result;
        if (result.isNotEmpty) {
          dateRange = dateRangeDefault = DateTimeRange(
            start: result.orderBy((x) => x.date).first.date,
            end: DateTime.now(),
          );
        }
        notifyListeners();
        return null;
      }),
  };
  List<Rating>? _source;

  /// 表示内容
  List<Rating>? get view => _view;
  List<Rating>? _view;

  /* SearchSheet */
  RatingRangeSelecterViewModel get ratingRange => _ratingRange;
  final RatingRangeSelecterViewModel _ratingRange = .new();

  /* Command */
  /// 検索
  @override
  void search() {
    _view = _source!
        .where((x) => ratingRange.min <= x.rating)
        .where((x) => x.rating <= ratingRange.max)
        .where((x) => dateRange.start.isBeforeAndSame(x.date))
        .where((x) => dateRange.end.isAfterAndSame(x.date))
        .toList();
    notifyListeners();
  }

  /// リセット
  @override
  void reset() {
    _view = _source!;
    _ratingRange.ratingReset();
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
