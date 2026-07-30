// Extention-method
import './extention/em_barcode_data.dart';
// Extention-type
import './extention/count.dart';
import './extention/jam.dart';
// Package
import 'package:darq/darq.dart';
import 'package:flutter/material.dart';
// Parts
import './parts/barcode_chip.dart';

class BarcodeViewer extends StatelessWidget {
  static const _spacing = Size(10.0, 10.0);

  const BarcodeViewer({super.key, required this.source});

  final Map<Count, Jam> source;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: _spacing.width,
      runSpacing: _spacing.height,
      children: source.entries
          .select((barcodeData, _) => barcodeChip(context, barcodeData))
          .toList(),
    );
  }

  @protected
  BarcodeChip barcodeChip(
    BuildContext context,
    MapEntry<Count, Jam> barcodeData,
  ) => BarcodeChip(barcodeData.displayData);
}
