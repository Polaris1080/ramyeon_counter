import 'package:darq/darq.dart';
import 'package:flutter/material.dart';
import 'package:ramyeon_counter/model/barcode.dart';
import 'package:ramyeon_counter/widget/detail_and_regist_page/barcode/parts/barcode_chip.dart';

class BarcodeViewer extends StatelessWidget {
  const BarcodeViewer(this.source, {super.key});

  final List<Barcode> source;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        ...source.select((s, _) => BarcodeChip('${s.count}個：${s.jam}')),
      ],
    );
  }
}
