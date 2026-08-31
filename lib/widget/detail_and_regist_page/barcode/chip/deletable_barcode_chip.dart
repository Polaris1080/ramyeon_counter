// Annotation
import 'package:ramyeon_counter/utility/annotations/viewmodel_annotation.dart';

// Base
import 'barcode_chip.dart';

// Package
import 'package:flutter/material.dart';

// Partial
part 'deletable_barcode_chip_vm.dart';

class const DeletableBarcodeChip({
  super.key,
  required DeletableBarcodeChipViewModel vm,
}) extends BarcodeChip {
  this : super(vm: vm);

  @override
  Widget build(BuildContext context) {
    final vm = this.vm as DeletableBarcodeChipViewModel;
    return InputChip(
      label: SizedBox(
        width: vm.width,
        child: Text(vm.data, textAlign: .end),
      ),
      padding: padding,
      labelPadding: labelPadding,
      onDeleted: vm.onIconPressed,
      onPressed: vm.onBodyPressed,
    );
  }
}
