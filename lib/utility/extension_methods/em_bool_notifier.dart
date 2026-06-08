import 'package:flutter/widgets.dart';

extension EmBoolNotifier on ValueNotifier<bool> {
  void flip() => value = !value;
}
