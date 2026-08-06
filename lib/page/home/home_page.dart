// Package
import 'package:darq/darq.dart';
import 'package:flutter/material.dart';
import 'package:ramyeon_counter/models/context/behind/ramyeon_list_data_context.dart';
import 'package:ramyeon_counter/models/context/ramyeon_list_data.dart';
// Model
import 'package:ramyeon_counter/models/model/repository/ramyeon_repository.dart';
import 'package:ramyeon_counter/page/home/parts/tile_a.dart';
import 'package:ramyeon_counter/page/home/parts/tile_b.dart';
// Widget
import 'package:ramyeon_counter/widget/custom_appbar/default_app_bar.dart';
import 'package:ramyeon_counter/page/home/parts/home_drawer.dart';
import 'package:ramyeon_counter/widget/custom_appbar/home_app_bar.dart';
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
