// Base
import 'package:ramyeon_counter/widget/detail_and_regist_page/base/chip_based_viewer.dart';
// Extension-method
import 'extension/em_barcode_data.dart';
// Extension-type
import 'extension/count.dart';
import 'extension/jam.dart';
// Package
import 'package:darq/darq.dart';
import 'package:flutter/material.dart';
// Parts
import './parts/barcode_chip.dart';

class BarcodeViewer extends ChipBasedViewer {
  const BarcodeViewer({super.key, required this.source});

  /* Argument */
  @protected
  final Map<Count, Jam> source;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: super.spacing.width,
      runSpacing: super.spacing.height,
      children: source.entries
          .select((barcodeData, _) => barcodeChip(context, barcodeData))
          .toList(),
    );
  }

  /* Widget */
  @protected
  Widget barcodeChip(BuildContext context, MapEntry<Count, Jam> source) =>
      BarcodeChip(source.displayData);
}
