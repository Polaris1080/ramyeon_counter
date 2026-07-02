import 'home_page.dart';
import 'package:flutter/material.dart';

class HomePageViewModel extends ChangeNotifier {
  bool get isCatalogMode => _isCatalogMode;
  bool _isCatalogMode = false;
  set isCatalogMode(bool value) {
    if (isCatalogMode != value) {
      _isCatalogMode = value;
      notifyListeners();
    }
  }

  bool get isSearchBarVisible => _isSearchBarVisible;
  bool _isSearchBarVisible = false;
  set isSearchBarVisible(bool value) {
    if (isSearchBarVisible != value) {
      _isSearchBarVisible = value;
      notifyListeners();
    }
  }

  RamyeonListOrder get orderBy => _orderBy;
  RamyeonListOrder _orderBy = .normal;
  set orderBy(RamyeonListOrder value) {
    if (orderBy != value) {
      _orderBy = value;
      notifyListeners();
    }
  }

  String get searchWord => _searchWord;
  String _searchWord = '';
  set searchWord(String value) {
    if (searchWord != value) {
      _searchWord = value;
      _orderBy = .normal;
      notifyListeners();
    }
  }
}
