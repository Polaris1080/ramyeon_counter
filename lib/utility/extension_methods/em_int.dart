import 'dart:math';

extension EmInt on int {
  int get digit => (log(this) ~/ ln10) + 1;
}
