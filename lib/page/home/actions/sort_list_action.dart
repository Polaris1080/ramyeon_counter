part of '../home_page.dart';

class SortListAction extends StatelessWidget {
  static const tooltip = '並替';
  static const Map<RamyeonListOrder, String> menuItem = {
    .normal: '名前',
    .rating: '評価',
    .price: '価格',
    .count: '個数',
    .limit: '期限',
  };

  const SortListAction(this.vm, {super.key});

  final HomePageViewModel vm;

  @override
  Widget build(BuildContext context) => MenuAnchor(
    menuChildren: menuItem.entries
        .select(
          (s, _) => MenuItemButton(
            child: Text(s.value),
            onPressed: () => vm.onSortListActionPressed(s.key),
          ),
        )
        .toList(),
    builder: (_, MenuController controller, _) => IconButton(
      icon: const Icon(Icons.list_alt),
      tooltip: tooltip,
      onPressed: () => switch (controller.isOpen) {
        true => controller.close(), // 開いている→閉じる
        false => controller.open(), // 閉じている→開く
      },
    ),
  );
}
