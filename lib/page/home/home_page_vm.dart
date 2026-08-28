part of 'home_page.dart';

class HomePageViewModel extends ChangeNotifier {
  ///
  @OneWay()
  bool get isCatalogMode => _isCatalogMode;
  bool _isCatalogMode = false;

  ///
  @OneWay()
  RamyeonListOrder get orderBy => _orderBy;
  RamyeonListOrder _orderBy = _defalutOrderBy;
  static const _defalutOrderBy = RamyeonListOrder.normal;

  ///
  @TwoWay()
  String get searchWord => _searchWord;
  String _searchWord = '';
  set searchWord(String value) {
    if (searchWord != value) {
      _searchWord = value;
      _orderBy = _defalutOrderBy;
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
