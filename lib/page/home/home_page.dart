// Package
import 'package:flutter/material.dart';

// Model
import 'package:ramyeon_counter/models/context/ramyeon/ramyeon_list_data.dart';
import 'package:ramyeon_counter/models/context/ramyeon/behind/ramyeon_list_data_context.dart';

// Widget
import 'package:ramyeon_counter/utility/annotations/viewmodel_annotation.dart';
import 'package:ramyeon_counter/utility/entension_factory/boxconstraints_factory.dart';
import 'package:ramyeon_counter/widget/custom_appbar/home_app_bar.dart';

// Parts
import 'package:ramyeon_counter/page/home/parts/home_drawer.dart';
import 'package:ramyeon_counter/page/home/parts/tile_a.dart';
import 'package:ramyeon_counter/page/home/parts/tile_b.dart';

// Other
import 'actions/base/home_page_action.dart';

// Partial
part 'home_page_vm.dart';
part 'home_search_bar.dart';
part 'enum/ramyeon_list_order.dart';
part 'parts/ramyeon_list_area.dart';

// ignore: prefer_const_constructors_in_immutables
class HomePage({super.key}) extends StatelessWidget {
  final HomePageViewModel vm = .new();

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = ColorScheme.of(context);
    return Theme(
      data: Theme.of(context).copyWith(
        bottomSheetTheme: BottomSheetThemeData(
          backgroundColor: Colors.transparent,
        ),
      ),
      child: Scaffold(
        appBar: HomeAppBar(
          context,
          vm,
          actions: [
            CatalogModeAction(parentVM: vm, childVM: .new(cs)),
            SearchBarAction(parentVM: vm, childVM: .new(cs)),
            SortListAction(parentVM: vm, childVM: .new(cs)),
          ],
        ),
        drawer: HomeDrawer(),
        body: RamyeonListArea(vm),
      ),
    );
  }
}
