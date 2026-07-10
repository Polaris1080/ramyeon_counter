import 'package:flutter/material.dart';

class BarcodeRegisterViewModel extends ChangeNotifier {
  Map<int, int> get source => _source;
  final Map<int, int> _source = {1: 8801073114920, 5: 8801073143319};



  /// code
  int get barcode => _barcode;
  int _barcode = 999999999_999_9;

  set barcodeText(String value) {
    var parsed = int.tryParse(value);
    if (parsed != null) {
      _barcode = parsed;
      notifyListeners();
    }
  }
  
  /* Selecter */
  int get countSelected => _countSelected;
  int _countSelected = 1;

  /* Command */
  void append() {
    _source.addAll({countSelected: barcode});
    notifyListeners();
  }

  void remove(int key) {
    _source.remove(key);
    notifyListeners();
  }

  void countChanged(Set<int> newSelection) {
    _countSelected = newSelection.first;
    notifyListeners();
  }
}
