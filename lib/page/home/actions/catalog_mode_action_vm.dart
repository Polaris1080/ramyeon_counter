part of 'base/home_page_action.dart';

class CatalogModeActionViewModel(final ColorScheme _colorScheme)
    extends HomePageActionViewModel {
  @OneTime()
  String tooltip = '在庫';

  @OneWay()
  Color get color => _mode
      //ON  color.
      ? Colors.yellow
      //OFF color.
      : _colorScheme.tertiaryContainer;

  bool _mode = false;
  @OneWayToSource()
  set isCatalogMode(bool value) {
    if (_mode != value) {
      _mode = value;
      notifyListeners();
    }
  }
}
