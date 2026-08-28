part of 'base/home_page_action.dart';

class const SearchBarAction({
  super.key,
  required final HomePageViewModel _parentVM,
  required final SearchBarActionViewModel vm,
}) extends HomePageAction {
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
