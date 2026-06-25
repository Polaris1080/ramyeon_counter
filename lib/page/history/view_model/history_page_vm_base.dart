// Package
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

abstract class HistoryPageViewModelBase extends ChangeNotifier {
  /* ViewSource */
  Future loadSource();

  /* Visible */
  bool get searchButtonVisible => isSourceNotNull && !isSourceEmpty;

  /* SearchSheet(Date) */
  DateTimeRange<DateTime> get dateRange => _dateRange;
  late DateTimeRange<DateTime> _dateRange;
  set dateRange(DateTimeRange<DateTime>? value) {
    if (value != null) {
      _dateRange = value;
      notifyListeners();
    }
  }

  @protected
  @nonVirtual
  void resetDateRange() => dateRange = dateRangeDefault;

  @nonVirtual
  late final DateTimeRange<DateTime> dateRangeDefault;

  /* Override */
  void search();
  void reset();
  bool get isSourceEmpty;
  bool get isSourceNotNull;
  bool get isSourceNull;
  int get listviewCount;
}
