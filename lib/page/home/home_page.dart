// Package
import 'package:darq/darq.dart';
import 'package:flutter/material.dart';
// Model
import 'package:ramyeon_counter/model/repository/ramyeon_repository.dart';
// Widget
import 'package:ramyeon_counter/widget/custom_app_bar.dart';
import 'package:ramyeon_counter/page/home/parts/home_drawer.dart';
import 'package:ramyeon_counter/page/home/parts/ramyeon_list_view.dart';
// Partial
part 'home_page_vm.dart';
part 'home_search_bar.dart';
part 'enum/ramyeon_list_order.dart';
part 'actions/catalog_mode_action.dart';
part 'actions/search_bar_action.dart';
part 'actions/sort_list_action.dart';
part 'parts/ramyeon_list_area.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final HomePageViewModel vm = .new();

  @override
  Widget build(BuildContext context) {
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
      body: RamyeonListArea(vm),
    );
  }
}
