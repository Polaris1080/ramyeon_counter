part of '../stock_page.dart';

class const SelectModeAction(final StockPageViewModel vm, {super.key})
    extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: vm,
      builder: (context, _) => switch ((vm.isSelectMode, vm.isSelectedCount)) {
        // Normal.
        (false, _) => IconButton(
          icon: const Icon(Icons.delete),
          tooltip: '削除',
          color: ColorScheme.of(context).tertiaryContainer,
          onPressed: () => vm.isSelectMode = true,
        ),
        // Selected Mode.
        (true, > 0) => IconButton(
          icon: const Icon(Icons.delete_forever),
          tooltip: '削除',
          color: Colors.yellow,
          onPressed: () => showDialog(
            context: context,
            builder: (context) => alertDialog(context),
          ),
        ),
        // Select Mode.
        (true, _) => IconButton(
          icon: const Icon(Icons.delete),
          tooltip: '削除',
          color: Colors.yellow,
          onPressed: () {
            // TODO:暫定処置
            if (vm.isSelectedCount > 0) {
              showDialog(
                context: context,
                builder: (context) => alertDialog(context),
              );
            } else {
              vm.isSelectMode = false;
            }
          },
        ),
      },
    );
  }

  @protected
  AlertDialog alertDialog(BuildContext context) {
    final definition = {
      'キャンセル': () {
        vm.isSelectMode = false;
        Navigator.pop(context);
      },
      '削除': () async {
        // DB削除
        await StockRepository().deleteMany(
          // id取得
          (vm.source!.select((s, _) => s.id))
              .zip(
                vm.isSelected!.select((s, _) => s.value),
                (id, isSelected) => isSelected ? id : null,
              )
              .whereType<int>()
              .toList(),
        );
        // VM再読込
        await vm.loadSource();
        vm.isSelectMode = false;
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
