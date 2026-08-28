import 'package:flutter/material.dart';

extension BoxConstraintsFactory on BoxConstraints {
  static BoxConstraints fromSize({required Size min, required Size max}) =>
      BoxConstraints(
        minWidth: min.width,
        maxWidth: max.width,
        minHeight: min.height,
        maxHeight: max.height,
      );
}
