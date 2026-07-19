part of '../stock_page.dart';

class SelectModeAction extends StatelessWidget {
  const SelectModeAction(this.vm, this.isSelectMode, {super.key});

  /* Argument */
  final StockPageViewModel vm;
  final ValueNotifier<bool> isSelectMode;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: isSelectMode,
      builder: (context, flag, _) => switch (flag) {
        // onModeButton
        true => IconButton(
          icon: const Icon(Icons.delete_forever),
          tooltip: '削除',
          color: Colors.yellow,
          onPressed: () {
            switch (vm.isSelected.count((isSelected) => isSelected.value)) {
              case 0:
                isSelectMode.flip();
                break;
              default:
                showDialog(context: context, builder: (c) => _dialog(c));
                break;
            }
          },
        ),
        // offModeButton
        false => IconButton(
          icon: const Icon(Icons.delete),
          tooltip: '削除',
          color: ColorScheme.of(context).tertiaryContainer,
          onPressed: () => isSelectMode.flip(),
        ),
      },
    );
  }

  /* Widget */
  AlertDialog _dialog(BuildContext context) {
    /// 「削除」ボタンが押されたとき
    Future onExecuteButtonPressed() async {
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
    }

    return AlertDialog(
      title: const Text('削除しますか？'),
      actions: [
        /* Cancel */
        TextButton(
          onPressed: () {
            isSelectMode.flip();
            Navigator.pop(context);
          },
          child: const Text('キャンセル'),
        ),
        /* Execute */
        TextButton(onPressed: onExecuteButtonPressed, child: const Text('削除')),
      ],
    );
  }
}
