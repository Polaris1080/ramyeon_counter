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
    return Stack(
      clipBehavior: .hardEdge,
      children: [vm.borderStyle, vm.baseStyle]
          .select((s, _) => Text(vm.title, style: s, maxLines: vm.maxLines))
          .toList(),
    );
  }
}

enum LayeredTextColor { primary, tertiary }
