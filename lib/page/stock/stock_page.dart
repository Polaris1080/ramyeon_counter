import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ramyeon_counter/model/stock.dart';
import 'package:ramyeon_counter/page/stock/stock_page_vm.dart';
import 'package:ramyeon_counter/utility/extension_methods/em_theme_data.dart';
import 'package:ramyeon_counter/widget/custom_app_bar.dart';
part './stock_postit_vm.dart';
part './stock_postit.dart';
part './stock_page_spacing_manager.dart';

class StockPage extends StatelessWidget {
  const StockPage({super.key, this.brandId, this.packageColor});

  final int? brandId;
  final Color? packageColor;

  @override
  Widget build(BuildContext context) {
    final viewModel = StockPageViewModel(brandId);

    final spacing = StockPageSpacingManager(MediaQuery.of(context).size.width);

    return
    /* Color change */
    Theme(
      data: Theme.of(context).override(packageColor),
      child: Scaffold(
        appBar: DefaultAppBar(context, '在庫'),
        body: Visibility(
          visible: spacing.gridviewVisible,
          child: Padding(
            padding: spacing.gridviewPadding,
            child: ListenableBuilder(
              listenable: viewModel,
              builder: (context, child) {
                return GridView.builder(
                  itemCount: viewModel.count,
                  itemBuilder: (context, index) {
                    return StockPostit(
                      viewModel: .new(viewModel.stock![index]),
                    );
                  },
                  gridDelegate: spacing.gridviewDelegate,
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
