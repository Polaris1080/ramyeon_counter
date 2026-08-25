// Extension
import 'extension/count.dart';
import 'extension/jam.dart';

// Package
import 'package:flutter/material.dart';

class BarcodeRegisterViewModel() extends ChangeNotifier {
  this {
    _sourceChanged(); // 初期化
    notifyListeners();
  }

  /* Setting */
  static final regexp = RegExp(r'^\d{8}$|^\d{13}$');

  Jam? get barcode => _barcode;
  Jam? _barcode;

  Count get countSelected => _countSelected;
  Count _countSelected = Count(1);

  /* source */
  Map<Count, Jam> get source => _source;
  final Map<Count, Jam> _source = {
    Count(1): Jam(8801073114920),
    Count(5): Jam(8801073143319),
  };

  /// 追加
  void _addSource() {
    _source[countSelected] = barcode!;
    _sourceChanged();
  }

  /// 削除
  void _removeSource(Count key) {
    _source.remove(key);
    _sourceChanged();
  }

  /// 変更された
  void _sourceChanged() {
    void selectCount() {
      int c = 1;
      for (Count count in _source.keys.toList()..sort()) {
        if (c == count) {
          c = count + 1;
        }
      }
      _countSelected = Count(c);
    }

    selectCount(); // 空いている箇所を見つける
    notifyListeners();
  }

  /* Command(DeletableBarcodeViewer) */
  VoidCallback? addButtonClicked() =>
      barcode == null ||
          source.containsKey(countSelected) ||
          source.containsValue(barcode!)
      ? null
      : _addSource;
  void removeButtonClicked(Count key) => _removeSource(key);

  /* Command(BarcodeEntry) */
  void textformChanged(String value) {
    _barcode = regexp.hasMatch(value) ? Jam(int.parse(value)) : null;
    notifyListeners();
  }

  String? textformValidated(String? value) => switch (value) {
    String value when !regexp.hasMatch(value) => '桁数が違います',
    _ => null,
  };

  /* Command(QuantitySelector) */
  void countChanged(Set<int> newSelection) {
    _countSelected = Count(newSelection.first);
    notifyListeners();
  }
}
