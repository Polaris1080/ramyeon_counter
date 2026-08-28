part of 'base/home_page_action.dart';

class const CatalogModeAction({
  super.key,
  required final HomePageViewModel _parentVM,
  required CatalogModeActionViewModel childVM,
}) extends HomePageAction {
  final CatalogModeActionViewModel vm = childVM;
  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _parentVM,
      builder: (_, _) {
        vm.isCatalogMode = _parentVM.isCatalogMode;
        return IconButton(
          icon: const Icon(Icons.warehouse_rounded),
          tooltip: vm.tooltip,
          color: vm.color,
          onPressed: _parentVM.onCatalogModeActionPressed,
        );
      },
    );
  }
}
