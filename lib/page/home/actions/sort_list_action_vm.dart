part of 'base/home_page_action.dart';

class SortListActionViewModel(ColorScheme colorScheme)
    extends HomePageActionViewModel {
  @OneTime()
  String tooltip = '並替';

  @OneTime()
  Color color = colorScheme.tertiaryContainer;
}
