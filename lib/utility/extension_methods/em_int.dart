import 'dart:math' as math;

extension EmInt on int {
  int get digit => this == 0 ? 1 : (math.log(this) ~/ math.ln10) + 1;
  int minmax({required int min, required int max}) {
    assert(!(min > max)); //（最小値が最大値より大きいのは）常識的におかしい
    return math.min(math.max(this, min), max);
  }
}
