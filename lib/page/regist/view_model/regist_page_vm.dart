import 'package:darq/darq.dart';
import 'package:flutter/material.dart';
import 'package:ramyeon_counter/model/repository/ramyeon_repository.dart';
import 'package:ramyeon_counter/page/regist/view_model/barcode_register_vm.dart';

class RegistPageViewModel extends ChangeNotifier {
  RegistPageViewModel(int? brandId) {
    if (brandId != null) {
      RamyeonRepository().read(brandId).then((x) {
        company = x.company;
        brand = x.brand;
        notifyListeners();
      });
    }
  }

  String get company => _company;
  String _company = '';
  set company(String value) {
    _company = value;
    notifyListeners();
  }

  String get brand => _brand;
  String _brand = '';
  set brand(String value) {
    _brand = value;
    notifyListeners();
  }

  Map<int, String> get tag => _tag;
  final Map<int, String> _tag = {0: 'からい', 1: 'おいしい'};
  void addTag(int a, String b) {
    _tag.addAll({a: b});
    notifyListeners();
  }

  void removeTag(int key) {
    _tag.remove(key);
    notifyListeners();
  }

  BarcodeRegisterViewModel barcodeRegister = .new();
}
