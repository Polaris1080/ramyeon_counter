part of '../stock_page.dart';

class SelectModeAction extends StatelessWidget {
  const SelectModeAction(this.vm, {super.key});

  final StockPageViewModel vm;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: vm,
      builder: (context, _) => vm.isSelectMode
          /* True */
          ? IconButton(
              icon: const Icon(Icons.delete_forever),
              tooltip: '削除',
              color: Colors.yellow,
              onPressed: () async {
                final selected = (await vm.source).where((w) => w.selected);
                // selected > 0
                if (selected.isNotEmpty && context.mounted) {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text("削除しますか？"),
                      actions: [
                        TextButton(
                          child: const Text("キャンセル"),
                          onPressed: () {
                            vm.isSelectMode = false;
                            Navigator.pop(context);
                          },
                        ),
                        TextButton(
                          child: const Text("削除"),
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
            )
          /* False */
          : IconButton(
              icon: const Icon(Icons.delete),
              tooltip: '削除',
              color: ColorScheme.of(context).tertiaryContainer,
              onPressed: () => vm.isSelectMode = true,
            ),
    );
  }
}
