// Package
import 'package:flutter/material.dart';

abstract class const ChipBasedViewer({super.key}) extends StatelessWidget {
  static const _spacing = Size(10.0, 10.0);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: _spacing.width,
      runSpacing: _spacing.height,
      children: chips(context),
    );
  }

  List<Widget> chips(BuildContext context);
}
