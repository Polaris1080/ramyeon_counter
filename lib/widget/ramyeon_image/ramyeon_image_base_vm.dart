import 'package:flutter/material.dart';

class RamyeonImageViewModelBase extends ChangeNotifier {
  String? get imagePath => _imagePath;
  String? _imagePath;
  set imagePath(String? value) {
    _imagePath = value;
    notifyListeners();
  }
}
