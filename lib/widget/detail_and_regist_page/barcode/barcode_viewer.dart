// Base
import '../base/chip_based_viewer.dart';

// Extension
import 'extension/count.dart';
import 'extension/em_barcode_data.dart';
import 'extension/jam.dart';

// Package
import 'package:flutter/material.dart';

// Parts
import 'parts/barcode_chip.dart';

class const BarcodeViewer({
  super.key,
  @protected required final Map<Count, Jam> source,
}) extends ChipBasedViewer {
  @override
  List<Widget> chips(BuildContext context) => source.entries
      .map((barcodeData) => barcodeChip(context, barcodeData))
      .toList();

  @protected
  Widget barcodeChip(BuildContext context, MapEntry<Count, Jam> source) =>
      BarcodeChip(vm: .new(data: source.displayData));
}
