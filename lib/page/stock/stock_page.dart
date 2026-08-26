// Annotation
import 'package:ramyeon_counter/utility/annotations/viewmodel_annotation.dart';

// Package
import 'package:intl/intl.dart';
import 'package:darq/darq.dart';
import 'package:flutter/material.dart';

// Model
import 'package:ramyeon_counter/models/model/ramyeon/repository/stock_repository.dart';
import 'package:ramyeon_counter/widget/other/postit.dart';

import 'postit/stock_postit_data.dart';

// Other
import 'package:ramyeon_counter/utility/extension_methods/em_bool_notifier.dart';
import 'package:ramyeon_counter/utility/extension_methods/em_theme_data.dart';
// Widget
import 'package:ramyeon_counter/widget/custom_appbar/default_app_bar.dart';
import 'package:ramyeon_counter/widget/other/image_background.dart';
import 'package:ramyeon_counter/widget/other/loading_progress_indicator.dart';
import 'package:ramyeon_counter/widget/other/spacing_grid_view.dart';
// Partial
part 'stock_page_vm.dart';
part 'actions/select_mode_action.dart';
part 'postit/stock_postit.dart';

class StockPage({super.key, required int? brandId, final Color? packageColor})
    extends StatelessWidget {
  this {
    isSelectMode.addListener(_isSelectModeChanged);
  }

  /* Value */
  final StockPageViewModel vm = .new(brandId);

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
          actions: [SelectModeAction(vm, isSelectMode: isSelectMode)],
        ),
        /* CorkBoard */
        body: ImageBackground(
          vm: .cork(),
          child: ListenableBuilder(
            listenable: vm,
            builder: (_, _) => switch (vm.source) {
              List<StockPostitData> data => postitGridView(context, data),
              _ => FutureBuilder(
                future: vm.loadSource(),
                builder: (context, snapshot) =>
                    switch (snapshot.connectionState) {
                      .done => postitGridView(context, snapshot.requireData),
                      _ => LoadingProgressIndicator(
                        context,
                        vm: .new(context, duration: .new(milliseconds: 100)),
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
  SpacingGridView postitGridView(
    BuildContext context,
    List<StockPostitData> data,
  ) => SpacingGridView(
    vm: .new(
      itemCount: data.length,
      itemSize: StockPostit.size,
      windowWidth: MediaQuery.of(context).size.width,
    ),
    itemBuilder: (context, i) => StockPostit(
      context,
      data: data[i],
      isSelectMode: isSelectMode,
      isSelected: vm.isSelected[i],
    ),
  );
}
