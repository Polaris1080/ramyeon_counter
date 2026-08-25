// Annotation
import 'package:ramyeon_counter/utility/annotations/viewmodel_annotation.dart';

// Package
import 'package:flutter/material.dart';

import '../../utility/extension_methods/em_range_values.dart';

class RatingRangeSelecterViewModel extends ChangeNotifier {
  /* Setting */
  static const _defaultRange = RangeValues(1.0, 10.0);

  /// 上限
  @OneWay()
  int get max => range.end.floor();
  set max(int value) {
    _range = _range.update(end: value);
    notifyListeners();
  }

  /// 下限
  @OneWay()
  int get min => range.start.floor();
  set min(int value) {
    _range = _range.update(start: value);
    notifyListeners();
  }

  /// 範囲
  RangeValues get range => _range;
  RangeValues _range = _defaultRange;

  /* Command */
  void ratingChanged(int value) {
    final absMin = (value - min).abs(), absMax = (value - max).abs();
    switch ((min - max).abs()) {
      case 0:
        if (value < min) {
          min = value;
        } else {
          max = value;
        }
        break;
      case 1:
        if (min == value || max == value) {
          if (max == value) {
            min = value;
          } else {
            max = value;
          }
        } else {
          if (value < min) {
            min = value;
          } else {
            max = value;
          }
        }
        break;
      default:
        if (absMin < absMax) {
          min = value;
        } else {
          max = value;
        }
    }
  }

  void ratingReset() {
    _range = _defaultRange;
    notifyListeners();
  }
}
