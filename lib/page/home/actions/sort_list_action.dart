part of '../home_page.dart';

class SortListAction extends StatelessWidget {
  const SortListAction(this.vm, {super.key});

  final HomePageViewModel vm;

  @override
  Widget build(BuildContext context) {
    return MenuAnchor(
      menuChildren: [
        for (({String data, RamyeonListOrder order}) item in [
          (data: '名前', order: .normal),
          (data: '評価', order: .rating),
          (data: '価格', order: .price),
          (data: '個数', order: .count),
          (data: '期限', order: .limit),
        ])
          MenuItemButton(
            child: Text(item.data),
            onPressed: () => vm.orderBy = item.order,
          ),
      ],
      builder: (_, MenuController controller, _) {
        return IconButton(
          icon: const Icon(Icons.list_alt),
          tooltip: '並替',
          onPressed: () => switch (controller.isOpen) {
            true => controller.close(), // 開いている→閉じる
            false => controller.open(), // 閉じている→開く
          },
        );
      },
    );
  }
}
