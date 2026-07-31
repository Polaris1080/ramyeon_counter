// Package
import 'package:flutter/material.dart';

class BarcodeChip extends StatelessWidget {
  /* Setting */
  @protected
  static const defaultWidth = 140.0;
  EdgeInsets get padding => const .all(0);
  EdgeInsets get labelPadding => const .all(0);

  const BarcodeChip(this.data, {super.key, this.chipWidth = defaultWidth});

  /* Argument */
  final String data;
  final double chipWidth;

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: SizedBox(
        width: chipWidth,
        child: Text(data, textAlign: .end),
      ),
      padding: padding,
      labelPadding: labelPadding,
    );
  }
}
