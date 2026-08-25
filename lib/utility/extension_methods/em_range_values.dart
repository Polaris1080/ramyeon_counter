import 'package:flutter/material.dart';

extension EmRangeValues on RangeValues {
  RangeValues update<T extends num>({T? start, T? end}) => .new(
    start != null ? start.toDouble() : this.start,
    end != null ? end.toDouble() : this.end,
  );
}
