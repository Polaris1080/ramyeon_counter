part of '../home_page.dart';

class SearchBarAction extends StatelessWidget {
  static const tooltip = '検索';

  const SearchBarAction(this.vm, {super.key});

  final HomePageViewModel vm;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: vm,
      builder: (context, _) => IconButton(
        icon: const Icon(Icons.search_rounded),
        tooltip: tooltip,
        color: ColorScheme.of(context).tertiaryContainer,
        onPressed: () => showModalBottomSheet(
          context: context,
          builder: (context) => HomeSearchBar(vm: vm),
        ),
      ),
    );
  }
}
