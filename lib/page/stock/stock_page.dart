// Package
import 'package:darq/darq.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
// Model
import 'package:ramyeon_counter/model/stock.dart';
import 'package:ramyeon_counter/model/repository/ramyeon_repository.dart';
import 'package:ramyeon_counter/model/repository/stock_repository.dart';
// Other
import 'package:ramyeon_counter/utility/extension_methods/em_theme_data.dart';
// Widget
import 'package:ramyeon_counter/widget/custom_app_bar.dart';
import 'package:ramyeon_counter/widget/image_background.dart';
import 'package:ramyeon_counter/widget/loading_progress_indicator.dart';
import 'package:ramyeon_counter/widget/spacing_grid_view/spacing_grid_view.dart';
// Partial
part 'stock_page_vm.dart';
part 'stock_postit.dart';
part 'stock_postit_vm.dart';
part 'actions/select_mode_action.dart';

class StockPage extends StatelessWidget {
  StockPage({super.key, required int? brandId, this.packageColor})
    : vm = .new(brandId);

  /* Value */
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
        /* CorkBoard */
        body: ImageBackground.cork(
          child: ListenableBuilder(
            listenable: vm,
            // vm.source.load
            builder: (context, _) => FutureBuilder(
              future: vm.source,
              builder: (context, snapshot) => switch (snapshot.data) {
                List<StockPostitViewModel> postitVM => SpacingGridView(
                  itemSize: StockPostit.size,
                  itemCount: postitVM.length,
                  itemBuilder: (context, i) => StockPostit(vm: postitVM[i]),
                ),
                _ => DelayedLoadingProgressIndicator.normal(context),
              },
            ),
          ),
        ),
      ),
    );
  }
}
