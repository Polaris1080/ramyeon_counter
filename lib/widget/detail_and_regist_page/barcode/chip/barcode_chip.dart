// Annotation
import 'package:ramyeon_counter/utility/annotations/viewmodel_annotation.dart';

// Base
import '../../base/viewer_chip_base.dart';
import '../../base/viewer_chip_base_vm.dart';

// Package
import 'package:flutter/material.dart';

// Partical
part 'barcode_chip_vm.dart';

class const BarcodeChip({super.key, required BarcodeChipViewModel vm})
    extends ViewerChipBase {
  final BarcodeChipViewModel _vm = vm;

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: SizedBox(
        width: _vm.width,
        child: Text(_vm.data, textAlign: .end),
      ),
      padding: padding,
      labelPadding: labelPadding,
    );
  }
}
