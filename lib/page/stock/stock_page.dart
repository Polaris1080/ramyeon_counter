// Package
import 'package:intl/intl.dart';
import 'package:darq/darq.dart';
import 'package:flutter/material.dart';
// Model
import 'package:ramyeon_counter/model/repository/stock_repository.dart';
import 'package:ramyeon_counter/widget/postit.dart';
import 'postit/stock_postit_data.dart';
// Other
import 'package:ramyeon_counter/utility/extension_methods/em_bool_notifier.dart';
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

class StockPage extends StatelessWidget {
  StockPage({super.key, required int? brandId, this.packageColor})
    : vm = .new(brandId) {
    isSelectMode.addListener(_isSelectModeChanged);
  }

  /* Argument */
  final Color? packageColor;

  /* Value */
  final StockPageViewModel vm;

  /// To [SelectModeAction]
  final ValueNotifier<bool> isSelectMode = .new(false);
  void _isSelectModeChanged() => vm.isSelected.forEach((f) => f.value = false);

  @override
  Widget build(BuildContext context) {
    return Theme(
      /* Color change */
      data: Theme.of(context).colorOverride(packageColor),
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
            builder: (_, _) => switch (vm.source) {
              List<StockPostitData> data => postitGridView(data),
              _ => FutureBuilder(
                future: vm.loadSource(),
                builder: (context, snapshot) =>
                    switch (snapshot.connectionState) {
                      .done => postitGridView(snapshot.requireData),
                      _ => LoadingProgressIndicator(
                        duration: .new(milliseconds: 100),
                      ),
                    },
              ),
            },
          ),
        ),
      ),
    );
  }

  /* Widget */
  SpacingGridView postitGridView(List<StockPostitData> data) => SpacingGridView(
    itemSize: StockPostit.size,
    itemCount: data.length,
    itemBuilder: (context, i) => StockPostit(
      context,
      data: data[i],
      isSelectMode: isSelectMode,
      isSelected: vm.isSelected[i],
    ),
  );
}
