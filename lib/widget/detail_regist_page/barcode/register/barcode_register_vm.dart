// Package
import 'package:flutter/material.dart';

class BarcodeRegisterViewModel extends ChangeNotifier {
  BarcodeRegisterViewModel() {
    selectCount();
  }

  Map<int, int> get source => _source;
  final Map<int, int> _source = {1: 8801073114920, 5: 8801073143319};

  /// code
  int? get barcode => _barcode;
  int? _barcode;

  /* Selecter */
  int get countSelected => _countSelected;
  int _countSelected = 1;

  /// 空いている箇所を見つける
  void selectCount() {
    int c = 1;
    for (var count in _source.keys.toList()..sort()) {
      if (c == count) {
        c = count + 1;
      }
    }
    _countSelected = c;
  }

  /* Command */
  void append() {
    if (barcode != null && !source.containsKey(countSelected)) {
      _source.addAll({countSelected: barcode!});
      selectCount();
      notifyListeners();
    }
  }

  void remove(int key) {
    _source.remove(key);
    selectCount();
    notifyListeners();
  }

  void countChanged(Set<int> newSelection) {
    _countSelected = newSelection.first;
    notifyListeners();
  }

  void textformChanged(String value) {
    final regexp = RegExp(r'^\d{8}$|^\d{13}$');
    _barcode = regexp.hasMatch(value) ? int.parse(value) : null;
    notifyListeners();
  }
}
