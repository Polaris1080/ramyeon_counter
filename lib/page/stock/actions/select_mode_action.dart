part of '../stock_page.dart';

class SelectModeAction extends StatelessWidget {
  /* Setting */
  static const _tooltip = '削除',
      _dialogTitle = '削除しますか？',
      _dialogOK = '削除',
      _dialogNG = 'キャンセル';

  const SelectModeAction(this.vm, {super.key});

  /* Value */
  final StockPageViewModel vm;

  @override
  Widget build(BuildContext context) {
    /* Color Setting */
    const onColor = Colors.yellow;
    final offColor = ColorScheme.of(context).tertiaryContainer;

    return ListenableBuilder(
      listenable: vm,
      builder: (context, _) => switch (vm.isSelectMode) {
        true => IconButton(
          icon: const Icon(Icons.delete_forever),
          tooltip: _tooltip,
          color: onColor,
          onPressed: () async {
            final selected = (await vm.source).where((w) => w.selected);
            // selected > 0
            if (selected.isNotEmpty && context.mounted) {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text(_dialogTitle),
                  actions: [
                    TextButton(
                      child: const Text(_dialogNG),
                      onPressed: () {
                        vm.isSelectMode = false;
                        Navigator.pop(context);
                      },
                    ),
                    TextButton(
                      child: const Text(_dialogOK),
                      onPressed: () async {
                        // DB削除
                        await StockRepository().deleteMany(
                          selected.select((s, _) => s.id).toList(),
                        );
                        // VM再読込
                        await vm.load();
                        vm.isSelectMode = false;
                        if (context.mounted) {
                          Navigator.pop(context);
                        }
                      },
                    ),
                  ],
                ),
              );
            }
            // selected = 0
            else {
              vm.isSelectMode = false;
            }
          },
        ),
        false => IconButton(
          icon: const Icon(Icons.delete),
          tooltip: _tooltip,
          color: offColor,
          onPressed: () => vm.isSelectMode = true,
        ),
      },
    );
  }
}
