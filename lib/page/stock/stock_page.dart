// Package
import 'package:darq/darq.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
// Model
import 'package:ramyeon_counter/model/stock.dart';
import 'package:ramyeon_counter/model/repository/stock_repository.dart';
// Other
import 'package:ramyeon_counter/page/stock/stock_page_vm.dart';
import 'package:ramyeon_counter/utility/extension_methods/em_theme_data.dart';
// Widget
import 'package:ramyeon_counter/widget/custom_app_bar.dart';
import 'package:ramyeon_counter/widget/loading_progress_indicator.dart';
import 'package:ramyeon_counter/widget/spacing_grid_view/spacing_grid_view.dart';
// Partial
part './stock_postit_vm.dart';
part './stock_postit.dart';
part 'actions/select_mode_action.dart';

class StockPage extends StatelessWidget {
  StockPage({super.key, required int? brandId, this.packageColor})
    : vm = .new(brandId);

  final StockPageViewModel vm;
  final Color? packageColor;

  @override
  Widget build(BuildContext context) {
    return
    /* Color change */
    Theme(
      data: Theme.of(context).override(packageColor),
      child: Scaffold(
        appBar: DefaultAppBar(context, '在庫', actions: [SelectModeAction(vm)]),
        body: ListenableBuilder(
          listenable: vm,
          builder: (context, _) {
            return FutureBuilder(
              future: vm.postit,
              builder: (context, snapshot) => switch (snapshot.data) {
                List<StockPostitViewModel> postitVM => SpacingGridView(
                  itemSize: StockPostit.size,
                  itemCount: postitVM.length,
                  itemBuilder: (context, index) =>
                      StockPostit(vm: postitVM[index]),
                ),
                _ => LoadingProgressIndicator.normal(context),
              },
            );
          },
        ),
      ),
    );
  }
}
