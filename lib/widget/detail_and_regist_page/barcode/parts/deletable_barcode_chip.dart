// Package

import 'package:flutter/material.dart';
import 'package:ramyeon_counter/widget/detail_and_regist_page/barcode/parts/barcode_chip.dart';

class DeletableBarcodeChip extends BarcodeChip {
  const DeletableBarcodeChip(
    super.data, {
    super.key,
    super.chipWidth = BarcodeChip.defaultWidth,
    this.onDeleted,
  });

  /* Argument */
  final Function()? onDeleted;

  @override
  Widget build(BuildContext context) {
    return InputChip(
      label: SizedBox(
        width: chipWidth,
        child: Text(data, textAlign: .end),
      ),
      padding: padding,
      labelPadding: labelPadding,
      onDeleted: onDeleted,
      onPressed: onDeleted == null ? () {} : null,
    );
  }
}
