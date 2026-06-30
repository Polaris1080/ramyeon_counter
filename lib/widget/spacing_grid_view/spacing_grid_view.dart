import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ramyeon_counter/page/stock/stock_page.dart';
import 'package:ramyeon_counter/page/stock/stock_page_vm.dart';
part './spacing_grid_view_manager.dart';

class SpacingGridView extends StatelessWidget {
  const SpacingGridView({super.key, required this.viewModel});

  final StockPageViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    final spacing = SpacingGridViewManager(MediaQuery.of(context).size.width);

    return Visibility(
      visible: spacing.gridviewVisible,
      child: Padding(
        padding: spacing.gridviewPadding,
        child: GridView.builder(
          itemCount: viewModel.count,
          itemBuilder: (context, index) {
            return StockPostit(
              viewModel: viewModel.post![index],
              brand: viewModel.brand![index]!,
              color: viewModel.color![index],
            );
          },
          gridDelegate: spacing.gridviewDelegate,
        ),
      ),
    );
  }
}
