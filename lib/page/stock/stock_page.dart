// Package
import 'package:darq/darq.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ramyeon_counter/model/base/context_base.dart';
import 'package:ramyeon_counter/model/ramyeon.dart';
// Model
import 'package:ramyeon_counter/model/stock.dart';
import 'package:ramyeon_counter/model/base/model_base.dart';
import 'package:ramyeon_counter/model/repository/stock_repository.dart';
import 'package:ramyeon_counter/ramyeon_database.dart';
import 'package:ramyeon_counter/utility/extension_methods/em_bool_notifier.dart';
// Other
import 'package:ramyeon_counter/utility/extension_methods/em_theme_data.dart';
// Widget
import 'package:ramyeon_counter/widget/custom_app_bar.dart';
import 'package:ramyeon_counter/widget/image_background.dart';
import 'package:ramyeon_counter/widget/loading_progress_indicator.dart';
import 'package:ramyeon_counter/widget/spacing_grid_view/spacing_grid_view.dart';
// Partial
part 'stock_page_vm.dart';
part 'actions/select_mode_action.dart';
part 'postit/stock_postit.dart';
part 'postit/stock_postit_context.dart';
part 'postit/stock_postit_data.dart';

class StockPage extends StatelessWidget {
  StockPage({super.key, required int? brandId, this.packageColor})
    : vm = .new(brandId) {
    isSelectMode.addListener(isSelectModeChanged);
  }

  /* Argument */
  final Color? packageColor;

  /* Value */
  final StockPageViewModel vm;
  final ValueNotifier<bool> isSelectMode = .new(false);
  void isSelectModeChanged() => vm.isSelected.forEach((f) => f.value = false);

  @override
  Widget build(BuildContext context) {
    return
    /* Color change */
    Theme(
      data: Theme.of(context).override(packageColor),
      child: Scaffold(
        appBar: DefaultAppBar(
          context,
          '在庫',
          actions: [SelectModeAction(vm, isSelectMode)],
        ),
        /* CorkBoard */
        body: ImageBackground.cork(
          child: ListenableBuilder(
            listenable: vm,
            // vm.source.load
            builder: (context, _) => FutureBuilder(
              future: vm.source,
              builder: (context, snapshot) {
                switch (snapshot.data) {
                  case List<StockPostitData> postitVM:
                    vm.isSelected = postitVM
                        .select((s, _) => ValueNotifier<bool>(false))
                        .toList();
                    return SpacingGridView(
                      itemSize: StockPostit.size,
                      itemCount: postitVM.length,
                      itemBuilder: (context, i) => StockPostit(
                        isSelectMode,
                        vm.isSelected[i],
                        vm: postitVM[i],
                      ),
                    );
                  default:
                    return DelayedLoadingProgressIndicator.normal(context);
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
