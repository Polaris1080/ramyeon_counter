// Extension-type
import 'extension/count.dart';
import 'extension/jam.dart';
// Package
import 'package:flutter/material.dart';
// Other
import 'barcode_register.dart';

class BarcodeRegisterViewModel extends ChangeNotifier {
  BarcodeRegisterViewModel() {
    // 初期化
    selectCount();
    notifyListeners();
  }

  Map<Count, Jam> get source => _source;
  final Map<Count, Jam> _source = {
    Count(1): Jam(8801073114920),
    Count(5): Jam(8801073143319),
  };

  Jam? get barcode => _barcode;
  Jam? _barcode;

  Count get countSelected => _countSelected;
  Count _countSelected = Count(1);

  /// 空いている箇所を見つける
  void selectCount() {
    int c = 1;
    for (Count count in _source.keys.toList()..sort()) {
      if (c == count.value) {
        c = count.value + 1;
      }
    }
    _countSelected = Count(c);
  }

  /* Command */
  /// [DeletableBarcodeViewer]
  VoidCallback? addButtonClicked() =>
      barcode == null ||
          source.containsKey(countSelected) ||
          source.containsValue(barcode!)
      ? null
      : () {
          _source[countSelected] = barcode!;
          selectCount();
          notifyListeners();
        };

  /// [DeletableBarcodeViewer]
  void removeButtonClicked(Count key) {
    _source.remove(key);
    selectCount();
    notifyListeners();
  }

  /// [QuantitySelector] segmentedButton changed.
  void countChanged(Set<int> newSelection) {
    _countSelected = Count(newSelection.first);
    notifyListeners();
  }

  /// [BarcodeEntry] textFormField changed.
  void textformChanged(String value) {
    _barcode = BarcodeEntry.regexp.hasMatch(value)
        ? Jam(int.parse(value))
        : null;
    notifyListeners();
  }
}
