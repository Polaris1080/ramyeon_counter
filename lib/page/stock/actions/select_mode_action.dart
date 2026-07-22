part of '../stock_page.dart';

class SelectModeAction extends StatelessWidget {
  const SelectModeAction(this.vm, this.isSelectMode, {super.key});

  /* Argument */
  final StockPageViewModel vm;
  final ValueNotifier<bool> isSelectMode;

  @override
  Widget build(BuildContext context) {
    final Map<bool, ({Color color, IconData icon, VoidCallback onPressed})>
    definition = {
      true: (
        color: Colors.yellow,
        icon: Icons.delete_forever,
        onPressed: () {
          if (vm.isSelected.any((isSelected) => isSelected.value)) {
            showDialog(
              context: context,
              builder: (context) => alertDialog(context),
            );
          }
          // 0(None)
          else {
            isSelectMode.flip();
          }
        },
      ),
      false: (
        color: ColorScheme.of(context).tertiaryContainer,
        icon: Icons.delete,
        onPressed: () => isSelectMode.flip(),
      ),
    };

    return ValueListenableBuilder(
      valueListenable: isSelectMode,
      builder: (_, flag, _) {
        final (:icon, :color, :onPressed) = definition[flag]!;
        return IconButton(
          icon: Icon(icon),
          tooltip: '削除',
          color: color,
          onPressed: onPressed,
        );
      },
    );
  }

  AlertDialog alertDialog(BuildContext context) {
    final Map<String, VoidCallback> definition = {
      'キャンセル': () {
        isSelectMode.flip();
        Navigator.pop(context);
      },
      '削除': () async {
        // DB削除
        await StockRepository().deleteMany(
          // id取得
          vm.source!
              .select((s, _) => s.id)
              // 結合
              .zip(
                vm.isSelected.select((s, _) => s.value),
                (id, isSelected) => MapEntry<int, bool>(id, isSelected),
              )
              // 選択
              .where((w) => w.value)
              // idだけ
              .select((s, _) => s.key)
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
      actions: [
        ...definition.entries.select(
          (s, _) => TextButton(onPressed: s.value, child: Text(s.key)),
        ),
      ],
    );
  }
}
