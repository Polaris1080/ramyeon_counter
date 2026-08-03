// Package
import 'package:darq/darq.dart';
import 'package:flutter/material.dart';
// Partial
part 'layered_text_vm.dart';

class LayeredText extends StatelessWidget {
  LayeredText(
    BuildContext context,
    String data, {
    super.key,
    required LayeredTextColor color,
    int? maxLines,
    double? fontSize,
    TextOverflow? overflow,
  }) : assert(overflow != .ellipsis), // ellipsisだと表示が乱れる
       vm = .new(context, data, color, maxLines, fontSize, overflow);

  final LayeredTextViewModel vm;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: .hardEdge,
      children: [vm.borderStyle, vm.baseStyle]
          .select((s, _) => Text(vm.text, style: s, maxLines: vm.maxLines))
          .toList(),
    );
  }
}

enum LayeredTextColor { primary, tertiary }
