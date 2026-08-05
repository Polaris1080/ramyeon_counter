// Package
import 'package:darq/darq.dart';
import 'package:flutter/material.dart';
// Partial
part 'layered_text_vm.dart';

class LayeredText extends StatelessWidget {
  const LayeredText({super.key, required this.vm});

  final LayeredTextViewModel vm;

  @override
  Widget build(BuildContext context) {
    /* Widget */
    Text text(TextStyle style) =>
        Text(vm.title, style: style, maxLines: vm.maxLines);
    /* Body */
    return Stack(
      clipBehavior: .hardEdge,
      children: [
        ...[vm.borderStyle, vm.baseStyle].select((style, _) => text(style)),
      ],
    );
  }
}

enum LayeredTextColor { primary, tertiary }
