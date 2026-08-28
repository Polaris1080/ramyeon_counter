part of 'base/home_page_action.dart';

class SearchBarActionViewModel(ColorScheme colorScheme)
    extends HomePageActionViewModel {
  @OneTime()
  String tooltip = '検索';

  @OneTime()
  Color color = colorScheme.tertiaryContainer;
}
