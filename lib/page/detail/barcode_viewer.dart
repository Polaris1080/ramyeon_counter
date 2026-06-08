import 'package:flutter/material.dart';
import 'package:ramyeon_counter/model/barcode.dart';

class BarcodeViewer extends StatelessWidget {
  const BarcodeViewer(this.source, {super.key});

  final List<Barcode> source;

  @override
  Widget build(BuildContext context) {
    var Map(entries: view) = {for (Barcode b in source) b.count: b.jam};

    return Wrap(
      children: [
        for (var MapEntry(key: count, value: jam) in view)
          Chip(label: Text('$count個：$jam')),
      ],
    );
  }
}
