part of '../stock_page.dart';

class const SelectModeAction(
  final StockPageViewModel vm, {
  super.key,
  required final ValueNotifier<bool> isSelectMode,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: isSelectMode,
      builder: (context, flag, _) => switch (flag) {
        true => IconButton(
          icon: const Icon(Icons.delete_forever),
          tooltip: '削除',
          color: Colors.yellow,
          onPressed: () {
            if (vm.isSelected.count((isSelected) => isSelected.value) > 0) {
              showDialog(
                context: context,
                builder: (context) => alertDialog(context),
              );
            } else {
              isSelectMode.flip();
            }
          },
        ),
        false => IconButton(
          icon: const Icon(Icons.delete),
          tooltip: '削除',
          color: ColorScheme.of(context).tertiaryContainer,
          onPressed: () => isSelectMode.flip(),
        ),
      },
    );
  }

  @protected
  AlertDialog alertDialog(BuildContext context) {
    final definition = {
      'キャンセル': () {
        isSelectMode.flip();
        Navigator.pop(context);
      },
      '削除': () async {
        // DB削除
        await StockRepository().deleteMany(
          // id取得
          (vm.source!.select((s, _) => s.id))
              .zip(
                vm.isSelected.select((s, _) => s.value),
                (id, isSelected) => isSelected ? id : null,
              )
              .whereType<int>()
              .toList(),
        );
        // VM再読込
        await vm.loadSource();
        isSelectMode.flip();
        if (context.mounted) {
          Navigator.pop(context);
        }
      },
    };

    return AlertDialog(
      title: const Text('削除しますか？'),
      actions: definition.entries
          .map((s) => TextButton(onPressed: s.value, child: Text(s.key)))
          .toList(),
    );
  }
}
