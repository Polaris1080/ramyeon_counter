part of 'base/home_page_action.dart';

class SortListActionViewModel(super.colorScheme)
    extends HomePageActionViewModel {
  @override
  @OneTime()
  String tooltip = '並替';

  @OneTime()
  Map<RamyeonListOrder, String> get menuItems => .fromEntries([
    RamyeonListOrder.normal.menuItem,
    // TODO:使用停止（暫定）
    //RamyeonListOrder.rating.menuItem,
    //RamyeonListOrder.price.menuItem,
    //RamyeonListOrder.count.menuItem,
    //RamyeonListOrder.limit.menuItem,
  ]);
}
