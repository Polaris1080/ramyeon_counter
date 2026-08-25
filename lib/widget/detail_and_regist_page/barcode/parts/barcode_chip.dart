// Package
import 'package:flutter/material.dart';

class const BarcodeChip(
  final String data, {
  super.key,
  final double chipWidth = defaultWidth,
}) extends StatelessWidget {
  @protected
  static const defaultWidth = 140.0;
  EdgeInsets get padding => const .all(0);
  EdgeInsets get labelPadding => const .all(0);

  /* Argument */
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
