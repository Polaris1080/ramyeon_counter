part of 'base/home_page_action.dart';

class CatalogModeActionViewModel(super.colorScheme)
    extends HomePageActionViewModel {
  @override
  @OneWay()
  Color get color => _mode
      // Mode:ON
      ? Colors.yellow
      // Mode:OFF
      : super.color;

  @override
  @OneTime()
  String tooltip = '在庫';

  bool _mode = false;
  @OneWayToSource()
  set isCatalogMode(bool value) {
    if (_mode != value) {
      _mode = value;
      notifyListeners();
    }
  }
}
