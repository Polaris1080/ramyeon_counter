// Annotation
import 'package:ramyeon_counter/utility/annotations/viewmodel_annotation.dart';

// Extension
import 'package:ramyeon_counter/utility/extension_methods/em_num.dart';

// Package
import 'package:flutter/material.dart';

// Partial
part 'spacing_grid_view_vm.dart';

class const SpacingGridView({
  super.key,
  required final SpacingGridViewViewModel vm,
  required final Widget? Function(BuildContext, int) _itemBuilder,
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
          itemBuilder: _itemBuilder,
        ),
      ),
    );
  }
}
