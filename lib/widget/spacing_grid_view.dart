// Package
import 'dart:math';

import 'package:flutter/material.dart';
// Annotation
import 'package:ramyeon_counter/utility/annotations/viewmodel_annotation.dart';
// Partial
part 'spacing_grid_view_vm.dart';

class const SpacingGridView({
  super.key,
  required final SpacingGridViewViewModel vm,
  required final Widget? Function(BuildContext, int) itemBuilder,
}) extends StatelessWidget {
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
