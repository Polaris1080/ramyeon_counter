import 'package:flutter/material.dart';
import 'package:ramyeon_counter/page/home/home_page_vm.dart';

class HomeSearchBar extends StatelessWidget {
  const HomeSearchBar({
    super.key,
    required this.vm,
    required this.searchbarController,
  });

  final HomePageViewModel vm;
  final TextEditingController searchbarController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Spacer(),
        ListenableBuilder(
          listenable: vm,
          builder: (_, w) {
            return Visibility(
              visible: vm.isSearchBarVisible,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Center(child: w!),
              ),
            );
          },
          /* SearchBar */
          child: SearchBar(
            // Enter-key pressed
            onSubmitted: (_) => vm.searchWord = searchbarController.text,
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
              Tooltip(
                message: 'リセット',
                child: IconButton(
                  onPressed: () {
                    searchbarController.clear();
                    vm.searchWord = '';
                  },
                  icon: const Icon(Icons.cancel_outlined),
                ),
              ),
            ],
            // Size
            constraints: BoxConstraints(
              minHeight: 40.0,
              maxHeight: 60.0,
              minWidth: 270.0,
              maxWidth: 540.0,
            ),
            // Textbox
            controller: searchbarController,
            // Place holder
            hintText: '例：ラーメン',
          ),
        ),
      ],
    );
  }
}
