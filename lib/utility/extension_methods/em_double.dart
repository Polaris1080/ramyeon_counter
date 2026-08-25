import 'dart:math' as math;

extension EmDouble on double {
  double minmax({required double min, required double max}) {
    //assert(!(min > max)); //（最小値が最大値より大きいのは）常識的におかしい
    return math.min(math.max(this, min), max);
  }
}
