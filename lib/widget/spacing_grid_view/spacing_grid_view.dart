// Package
import 'dart:math';
import 'package:flutter/material.dart';
// Partial
part './spacing_grid_view_manager.dart';

class SpacingGridView extends StatelessWidget {
  const SpacingGridView({
    super.key,
    required this.itemBuilder,
    required this.itemSize,
    this.itemCount,
  });

  final Widget? Function(BuildContext, int) itemBuilder;
  final Size itemSize;
  final int? itemCount;

  @override
  Widget build(BuildContext context) {
    final spacing = SpacingGridViewManager(
      windowWidth: MediaQuery.of(context).size.width,
      itemSize: itemSize,
    );

    return Visibility(
      visible: spacing.gridviewVisible,
      child: Padding(
        padding: spacing.gridviewPadding,
        child: GridView.builder(
          itemCount: itemCount,
          itemBuilder: itemBuilder,
          gridDelegate: spacing.gridviewDelegate,
        ),
      ),
    );
  }
}
