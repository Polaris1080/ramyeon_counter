part of 'base/home_page_action.dart';

class const SortListAction({
  super.key,
  required final HomePageViewModel _parentVM,
  required final SortListActionViewModel vm,
}) extends HomePageAction {
  static const Map<RamyeonListOrder, String> menuItem = {
    .normal: '名前',
    .rating: '評価',
    .price: '価格',
    .count: '個数',
    .limit: '期限',
  };

  @override
  Widget build(BuildContext context) => MenuAnchor(
    menuChildren: menuItem.entries
        .map(
          (s) => MenuItemButton(
            child: Text(s.value),
            onPressed: () => _parentVM.onSortListActionPressed(s.key),
          ),
        )
        .toList(),
    builder: (_, MenuController controller, _) => IconButton(
      icon: const Icon(Icons.list_alt),
      tooltip: vm.tooltip,
      color: vm.color,
      onPressed: () => switch (controller.isOpen) {
        true => controller.close(), // 開いている→閉じる
        false => controller.open(), // 閉じている→開く
      },
    ),
  );
}
