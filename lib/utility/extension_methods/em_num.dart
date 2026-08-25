import 'dart:math' as math;

extension EmNum<T extends num> on T {
  bool inRange({
    required T min,
    required T max,
    bool minEqual = true,
    bool maxEqual = true,
  }) {
    assert(!(min > max)); //（最小値が最大値より大きいのは）常識的におかしい
    return switch ((minEqual, maxEqual)) {
      (true, true) => min <= this && this <= max,
      (false, true) => min < this && this <= max,
      (true, false) => min <= this && this < max,
      (false, false) => min < this && this < max,
    };
  }

  T minmax({required T min, required T max}) {
    //assert(!(min > max)); //（最小値が最大値より大きいのは）常識的におかしい
    return math.min(math.max(this, min), max);
  }
}
