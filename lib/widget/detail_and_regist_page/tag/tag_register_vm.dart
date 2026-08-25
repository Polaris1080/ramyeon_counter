// Annotation
import 'package:ramyeon_counter/utility/annotations/viewmodel_annotation.dart';

// Package
import 'package:flutter/material.dart';

class TagRegisterViewModel(int? brandId) extends ChangeNotifier {
  this {
    //if (brandId != null) {}
  }

  static final regexp = RegExp(r'^[\u3040-\u30ff]{3,5}$');

  @OneWay()
  String? get tag => _tag;
  String? _tag;

  @OneWay()
  List<String> get source => _source;
  List<String> _source = ['からい', 'おいしい'];
  void _addSource() {
    final tags = _source;
    tags.add(tag!);
    _source = (tags..sort());
    notifyListeners();
  }

  void removeSource(int key) {
    _source.removeAt(key);
    notifyListeners();
  }

  /* Command */
  /* (Entry) */
  VoidCallback? addButtonClicked() => tag == null
      //  ||
      //     source.containsKey(countSelected) ||
      //     source.containsValue(barcode!)
      ? null
      : _addSource;

  void textformChanged(String value) {
    _tag = regexp.hasMatch(value) ? value : null;
    notifyListeners();
  }

  String? textformValidated(String? value) => switch (value) {
    String value when !regexp.hasMatch(value) => '桁数が違います',
    _ => null,
  };
}
