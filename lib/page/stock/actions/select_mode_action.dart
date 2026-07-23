part of '../stock_page.dart';

class SelectModeAction extends StatelessWidget {
  const SelectModeAction(this.vm, this.isSelectMode, {super.key});

  /* Argument */
  final StockPageViewModel vm;

  /// From [StockPage]
  final ValueNotifier<bool> isSelectMode;

  @override
  Widget build(BuildContext context) {
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
            .select(
              (s, _) => TextButton(onPressed: s.value, child: Text(s.key)),
            )
            .toList(),
      );
    }

    return ValueListenableBuilder(
      valueListenable: isSelectMode,
      builder: (context, flag, _) => switch (flag) {
        true => IconButton(
          icon: const Icon(Icons.delete_forever),
          tooltip: '削除',
          color: Colors.yellow,
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
        false => IconButton(
          icon: const Icon(Icons.delete),
          tooltip: '削除',
          color: ColorScheme.of(context).tertiaryContainer,
          onPressed: () => isSelectMode.flip(),
        ),
      },
    );
  }
}
