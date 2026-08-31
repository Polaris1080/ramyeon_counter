// Package
import 'package:flutter/material.dart';

abstract class const ChipBasedRegister({super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 10.0, //【Vertical spacing】
      children: components,
    );
  }

  /// Register parts.
  //@mustBeOverridden
  List<Widget> get components;
}
