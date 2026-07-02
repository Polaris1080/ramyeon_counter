import 'package:ramyeon_counter/model/context/ramyeon_list_data_context.dart';
import 'package:ramyeon_counter/page/home/home_search_bar.dart';

import 'home_page_vm.dart';
import 'package:flutter/material.dart';
import 'package:ramyeon_counter/widget/custom_app_bar.dart';
import 'package:ramyeon_counter/widget/home_page/home_drawer.dart';
import 'package:ramyeon_counter/widget/home_page/ramyeon_list.dart';
// Partial
part './actions/catalog_mode_action.dart';
part './actions/search_bar_action.dart';
part './actions/sort_list_action.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = HomePageViewModel();
    final searchbarController = TextEditingController();

    return Scaffold(
      appBar: HomeAppBar(
        context,
        vm,
        actions: [
          CatalogModeAction(vm),
          SearchBarAction(vm),
          SortListAction(vm),
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
                future: RamyeonListDataContext().readByBrand(vm.searchWord),
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
                      color: ColorScheme.of(context).tertiary,
                    );
                  }
                },
              );
            },
          ),

          //TODO 要整備（ロゴ：List-style）
          HomeSearchBar(vm: vm, searchbarController: searchbarController),
        ],
      ),
    );
  }
}

enum RamyeonListOrder { normal, rating, price, count, limit }
