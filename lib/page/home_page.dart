import 'package:ramyeon_counter/model/repository/ramyeon_repository.dart';

import 'home_page_vm.dart';
import 'package:flutter/material.dart';
import 'package:ramyeon_counter/widget/custom_app_bar.dart';
import 'package:ramyeon_counter/widget/home_page/home_drawer.dart';
import 'package:ramyeon_counter/widget/home_page/ramyeon_list.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = HomePageViewModel();
    final TextEditingController searchbarController = TextEditingController();

    Color iconColor(bool f) =>
        f ? Colors.yellow : Theme.of(context).colorScheme.tertiaryContainer;

    return Scaffold(
      /* AppBar */
      appBar: HomeAppBar(
        context,
        vm,
        actions: [
          // Catalog
          ListenableBuilder(
            listenable: vm,
            builder: (_, _) {
              return IconButton(
                icon: const Icon(Icons.warehouse_rounded),
                tooltip: '在庫',
                color: iconColor(vm.isCatalogMode),
                onPressed: () => vm.isCatalogMode = !vm.isCatalogMode,
              );
            },
          ),
          // Search
          ListenableBuilder(
            listenable: vm,
            builder: (context, _) {
              return IconButton(
                icon: const Icon(Icons.search_rounded),
                tooltip: '検索',
                color: iconColor(vm.isSearchBarVisible),
                onPressed: () => vm.isSearchBarVisible = !vm.isSearchBarVisible,
              );
            },
          ),
          // Sort
          MenuAnchor(
            menuChildren: [
              for (({String data, RamyeonListOrder order}) t in [
                (data: '名前', order: .normal),
                (data: '評価', order: .rating),
                (data: '価格', order: .price),
                (data: '個数', order: .count),
                (data: '期限', order: .limit),
              ])
                MenuItemButton(
                  child: Text(t.data),
                  onPressed: () => vm.orderBy = t.order,
                ),
            ],
            builder: (_, MenuController controller, _) {
              return IconButton(
                icon: const Icon(Icons.list_alt),
                tooltip: '並替',
                onPressed: () =>
                    controller.isOpen ? controller.close() : controller.open(),
              );
            },
          ),
        ],
      ),
      drawer: HomeDrawer(),
      body: Stack(
        children: [
          /* ListView */
          ListenableBuilder(
            listenable: vm,
            builder: (context, child) {
              return FutureBuilder(
                future: RamyeonRepository().readByBrand(vm.searchWord),
                builder: (context, asyncSnapshot) {
                  if (asyncSnapshot.hasData) {
                    return RamyeonList(
                      asyncSnapshot.data!,
                      vm.orderBy,
                      vm.isCatalogMode,
                    );
                  } else if (asyncSnapshot.hasData &&
                      asyncSnapshot.data!.isEmpty) {
                    return Center(
                      child: Text(
                        '見つかりません',
                        style: TextStyle(
                          fontFamily: 'ZenKakuGothic',
                          fontSize: 24,
                          fontWeight: .w500,
                        ),
                      ),
                    );
                  } else if (asyncSnapshot.hasError) {
                    return Center(
                      child: Text(
                        'エラーが発生しました',
                        style: TextStyle(
                          fontFamily: 'ZenKakuGothic',
                          fontSize: 24,
                          fontWeight: .w500,
                        ),
                      ),
                    );
                  }
                  // Loading...
                  else {
                    return LinearProgressIndicator(
                      color: Theme.of(context).colorScheme.tertiary,
                    );
                  }
                },
              );
            },
          ),

          //TODO 要整備（ロゴ：List-style）
          Column(
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
          ),
        ],
      ),
    );
  }
}

enum RamyeonListOrder { normal, rating, price, count, limit }
