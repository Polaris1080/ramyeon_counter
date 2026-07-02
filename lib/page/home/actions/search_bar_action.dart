part of '../home_page.dart';

class SearchBarAction extends StatelessWidget {
  const SearchBarAction(this.vm, {super.key});

  final HomePageViewModel vm;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: vm,
      builder: (context, _) => IconButton(
        icon: const Icon(Icons.search_rounded),
        tooltip: '検索',
        color: switch (vm.isSearchBarVisible) {
          true => Colors.yellow,
          false => ColorScheme.of(context).tertiaryContainer,
        },
        onPressed: () => vm.isSearchBarVisible = !vm.isSearchBarVisible,
      ),
    );
  }
}
