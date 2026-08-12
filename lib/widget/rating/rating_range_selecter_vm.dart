import 'package:flutter/material.dart';

class RatingRangeSelecterViewModel extends ChangeNotifier {
  /* Setting */
  static const _defaultRange = RangeValues(1.0, 10.0);

  /// 上限
  int get max => range.end.floor();
  set max(int value) {
    _range = .new(range.start, value.toDouble());
    notifyListeners();
  }

  /// 範囲
  RangeValues get range => _range;
  RangeValues _range = _defaultRange;

  /// 下限
  int get min => range.start.floor();
  set min(int value) {
    _range = .new(value.toDouble(), range.end);
    notifyListeners();
  }

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
