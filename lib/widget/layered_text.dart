// Package
import 'package:darq/darq.dart';
import 'package:flutter/material.dart';
// Annotation
import 'package:ramyeon_counter/utility/annotations/viewmodel_annotation.dart';
// Partial
part 'layered_text_vm.dart';

class const LayeredText({super.key, required final LayeredTextViewModel vm})
    extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: .hardEdge,
      children: [
        ...[vm.borderStyle, vm.baseStyle].select(
          (style, _) => Text(vm.title, style: style, maxLines: vm.maxLines),
        ),
      ],
    );
  }
}

/// [LayeredText]_[Color] selector.
enum LayeredTextColor { primary, tertiary }
