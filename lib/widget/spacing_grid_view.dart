// Package
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:ramyeon_counter/utility/annotations/viewmodel_annotation.dart';
// Partial
part 'spacing_grid_view_vm.dart';

class SpacingGridView extends StatelessWidget {
  const SpacingGridView({
    super.key,
    required this.vm,
    required this.itemBuilder,
  });

  final SpacingGridViewViewModel vm;

  /* Argument */
  final Widget? Function(BuildContext, int) itemBuilder;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: vm.gridviewVisible,
      child: Padding(
        padding: vm.gridviewPadding,
        child: GridView.builder(
          gridDelegate: vm.gridviewDelegate,
          itemCount: vm.count,
          itemBuilder: itemBuilder,
        ),
      ),
    );
  }
}
