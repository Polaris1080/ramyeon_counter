part of 'home_page.dart';

class HomePageViewModel extends ChangeNotifier {
  static const _orderByDefault = RamyeonListOrder.normal;

  bool get isCatalogMode => _isCatalogMode;
  bool _isCatalogMode = false;

  RamyeonListOrder get orderBy => _orderBy;
  RamyeonListOrder _orderBy = _orderByDefault;

  String get searchWord => _searchWord;
  String _searchWord = '';
  set searchWord(String value) {
    if (searchWord != value) {
      _searchWord = value;
      _orderBy = _orderByDefault;
      notifyListeners();
    }
  }

  /* onPressed */
  void onCatalogModeActionPressed() {
    _isCatalogMode = !_isCatalogMode;
    notifyListeners();
  }

  void onSortListActionPressed(RamyeonListOrder value) {
    _orderBy = value;
    notifyListeners();
  }
}
