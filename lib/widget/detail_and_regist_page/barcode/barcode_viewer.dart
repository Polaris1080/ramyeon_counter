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
  const BarcodeViewer(this.source, {super.key});

  final Map<Count, Jam> source;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: source.entries
          .select((s, _) => BarcodeChip(s.displayData))
          .toList(),
    );
  }
}
