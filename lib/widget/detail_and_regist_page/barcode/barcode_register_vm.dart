// Package
import 'package:flutter/material.dart';
import 'package:ramyeon_counter/widget/detail_and_regist_page/barcode/extention/count.dart';
import 'package:ramyeon_counter/widget/detail_and_regist_page/barcode/extention/jam.dart';

class BarcodeRegisterViewModel extends ChangeNotifier {
  BarcodeRegisterViewModel() {
    selectCount(); // 初期化
  }

  Map<Count, Jam> get source => _source;
  final Map<Count, Jam> _source = {
    Count(1): Jam(8801073114920),
    Count(5): Jam(8801073143319),
  };

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
      if (c == count.value) {
        c = count.value + 1;
      }
    }
    _countSelected = c;
  }

  /* Command */
  void append() {
    if (barcode != null && !source.containsKey(countSelected)) {
      _source.addAll({Count(countSelected) : Jam(barcode!)});
      selectCount(); // 変動
      notifyListeners();
    }
  }

  void remove(int key) {
    _source.remove(key);
    selectCount(); // 変動
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
