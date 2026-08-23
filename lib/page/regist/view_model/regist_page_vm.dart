import 'package:darq/darq.dart';
import 'package:flutter/material.dart';
import 'package:ramyeon_counter/models/model/ramyeon/repository/ramyeon_repository.dart';
import 'package:ramyeon_counter/widget/detail_and_regist_page/barcode/barcode_register_vm.dart';
import 'package:ramyeon_counter/widget/detail_and_regist_page/tag/register/tag_register_vm.dart';

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

  TagRegisterViewModel tagRegister = .new(0);
  BarcodeRegisterViewModel barcodeRegister = .new();
}
