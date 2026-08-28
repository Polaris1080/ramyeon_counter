part of 'base/home_page_action.dart';

class const SearchBarAction({
  super.key,
  required final HomePageViewModel _parentVM,
  required SearchBarActionViewModel childVM,
}) extends HomePageAction {
  final SearchBarActionViewModel vm = childVM;
  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _parentVM,
      builder: (context, _) => IconButton(
        icon: const Icon(Icons.search_rounded),
        tooltip: vm.tooltip,
        color: vm.color,
        onPressed: () => showModalBottomSheet(
          context: context,
          builder: (context) => HomeSearchBar(vm: _parentVM),
        ),
      ),
    );
  }
}
