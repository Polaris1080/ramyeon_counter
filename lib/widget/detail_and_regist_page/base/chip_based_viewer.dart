// Package
import 'package:flutter/material.dart';

abstract class const ChipBasedViewer({super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10.0, //【Vertical spacing】
      runSpacing: 10.0, //【Horizontal spacing】
      children: chips,
    );
  }

  /// [Chip] Phenotype.
  //@mustBeOverridden
  List<Widget> get chips;
}
