part of '../home_page.dart';

class CatalogModeAction extends StatelessWidget {
  const CatalogModeAction(this.vm, {super.key});

  final HomePageViewModel vm;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: vm,
      builder: (_, _) => IconButton(
        icon: const Icon(Icons.warehouse_rounded),
        tooltip: '在庫',
        color: switch (vm.isCatalogMode) {
          true => Colors.yellow,
          false => ColorScheme.of(context).tertiaryContainer,
        },
        onPressed: () => vm.isCatalogMode = !vm.isCatalogMode,
      ),
    );
  }
}
