import 'package:flutter/material.dart';

class TagRegisterViewModel extends ChangeNotifier {
  TagRegisterViewModel(int? brandId) {
    if (brandId != null) {}
  }

  List<String> get tag => _tag;
  List<String> _tag = ['からい', 'おいしい'];
  void append(int a, String b) {
    final tags = _tag;
    tags.add(b);
    _tag = (tags..sort());
    notifyListeners();
  }

  void remove(int key) {
    _tag.removeAt(key);
    notifyListeners();
  }
}
