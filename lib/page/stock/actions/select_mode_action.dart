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
      builder: (c, flag, _) => flag ? _onModeButton(c) : _offModeButton(c),
    );
  }

  /* Widget */
  IconButton _onModeButton(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.delete_forever),
      tooltip: '削除',
      color: Colors.yellow,
      onPressed: () => _onModeButtonPressed(context),
    );
  }

  IconButton _offModeButton(BuildContext context) => IconButton(
    icon: const Icon(Icons.delete),
    tooltip: '削除',
    color: ColorScheme.of(context).tertiaryContainer,
    onPressed: () => isSelectMode.flip(),
  );

  /* Event */
  Future _onModeButtonPressed(BuildContext context) async {
    /// 「削除」ボタンが押されたとき
    Future onExecuteButtonPressed() async {
      // DB削除
      await StockRepository().deleteMany(
        // id取得
        (await vm.source)
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
      await vm.load();
      isSelectMode.flip();
      if (context.mounted) {
        Navigator.pop(context);
      }
    }

    if (vm.isSelected.any((a) => a.value)) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
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
            TextButton(
              onPressed: onExecuteButtonPressed,
              child: const Text('削除'),
            ),
          ],
        ),
      );
    } else {
      isSelectMode.flip();
    }
  }
}
