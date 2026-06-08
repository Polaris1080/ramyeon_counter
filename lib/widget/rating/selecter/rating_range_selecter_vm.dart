import 'package:flutter/material.dart';

class RatingRangeSelecterViewModel extends ChangeNotifier {
  /// 下限
  int get min => _min;
  int _min = _defaultMin;
  static const _defaultMin = 1;

  /// 上限
  int get max => _max;
  int _max = _defaultMax;
  static const _defaultMax = 10;

  void ratingChanged(int value) {
    if (min == max && min != value) {
      if (value < min) {
        _min = value;
      } else {
        _max = value;
      }
    } else {
      int absMin = (value - min).abs(), absMax = (value - max).abs();
      if (absMin <= 1 && absMax <= 1) {
        _min = _max = value;
      } else if (absMin <= absMax) {
        _min = value;
      } else {
        _max = value;
      }
    }
    notifyListeners();
  }

  void ratingReset() {
    _min = _defaultMin;
    _max = _defaultMax;
    notifyListeners();
  }
}
