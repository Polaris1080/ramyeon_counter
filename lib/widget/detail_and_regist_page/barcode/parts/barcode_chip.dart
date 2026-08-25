// Annotation
import 'package:ramyeon_counter/utility/annotations/viewmodel_annotation.dart';

// Package
import 'package:flutter/material.dart';

// Partical
part 'barcode_chip_vm.dart';

class const BarcodeChip({super.key, required BarcodeChipViewModel vm})
    extends StatelessWidget {
  final BarcodeChipViewModel _vm = vm;

  /* Setting */
  @protected
  EdgeInsets get padding => const .all(0);
  @protected
  EdgeInsets get labelPadding => const .all(0);

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
