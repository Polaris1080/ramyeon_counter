part of 'base/home_page_action.dart';

class const SortListAction({
  super.key,
  required final HomePageViewModel _parentVM,
  required final SortListActionViewModel vm,
}) extends HomePageAction {
  @override
  Widget build(BuildContext context) => MenuAnchor(
    menuChildren: vm.menuItems.entries
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
