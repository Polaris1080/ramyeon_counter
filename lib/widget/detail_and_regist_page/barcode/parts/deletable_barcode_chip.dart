// Base
import '../parts/barcode_chip.dart';

// Package
import 'package:flutter/material.dart';

class const DeletableBarcodeChip(
  super.data, {
  super.key,
  super.chipWidth,
  final Function()? _onDeleted,
}) extends BarcodeChip {
  @override
  Widget build(BuildContext context) {
    return InputChip(
      label: SizedBox(
        width: chipWidth,
        child: Text(data, textAlign: .end),
      ),
      padding: padding,
      labelPadding: labelPadding,
      onDeleted: _onDeleted,
      onPressed: _onDeleted == null ? () {} : null,
    );
  }
}
