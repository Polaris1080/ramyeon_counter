part of './home_page.dart';

// ignore: prefer_const_constructors_in_immutables
class HomeSearchBar({super.key, required final HomePageViewModel vm})
    extends StatelessWidget {
  static const minSize = Size(270.0, 40), maxSize = Size(540.0, 60);

  final TextEditingController searchbarController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SearchAnchor(
        builder: (BuildContext context, SearchController controller) {
          return SearchBar(
            controller: searchbarController,
            // Search-button clicked
            leading: Tooltip(
              message: '検索',
              child: IconButton(
                onPressed: () => vm.searchWord = searchbarController.text,
                icon: const Icon(Icons.search_outlined),
              ),
            ),
            // Reset-button clicked
            trailing: [
              /* どうやらTooltip併用時エラー Failed to update ui::AXTree */
              // Tooltip(
              //   message: 'リセット',
              //   child:
              IconButton(
                onPressed: () {
                  searchbarController.clear();
                  vm.searchWord = '';
                },
                icon: const Icon(Icons.cancel_outlined),
              ),
              // ),
            ],
            constraints: BoxConstraints(
              minHeight: minSize.height,
              maxHeight: maxSize.height,
              minWidth: minSize.width,
              maxWidth: maxSize.width,
            ),
            hintText: '例：ラーメン', // Placeholder.
            // Enter-key pressed
            onSubmitted: (_) => vm.searchWord = searchbarController.text,
          );
        },
        // TODO:余裕があれば
        suggestionsBuilder: (
          BuildContext context,
          SearchController controller,
        ) => [],
      ),
    );
  }
}
