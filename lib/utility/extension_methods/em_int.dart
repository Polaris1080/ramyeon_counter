import 'dart:math' as math;

extension EmInt on int {
  int get digit => this == 0 ? 1 : (math.log(this) ~/ math.ln10) + 1;
}
