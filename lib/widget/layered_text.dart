import 'package:darq/darq.dart';
import 'package:flutter/material.dart';

class LayeredText extends StatelessWidget {
  const LayeredText(
    this.data, {
    super.key,
    required this.color,
    this.fontSize,
    this.maxLines,
    this.overflow,
  }) : assert(overflow != .ellipsis); // ellipsisだと表示が乱れる

  const LayeredText.primary(
    this.data, {
    super.key,
    this.fontSize,
    this.maxLines,
    this.overflow,
  }) : color = .primary;

  const LayeredText.tertiary(
    this.data, {
    super.key,
    this.fontSize,
    this.maxLines,
    this.overflow,
  }) : color = .tertiary;

  /* Argument */
  final String data;
  final double? fontSize;
  final TextOverflow? overflow;
  final int? maxLines;

  /// Color selection
  final LayeredTextColor color;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return DefaultTextStyle.merge(
      style: TextStyle(
        fontFamily: 'ZenMaruGothic',
        fontSize: fontSize,
        overflow: overflow,
      ),
      child: Stack(
        clipBehavior: .hardEdge,
        children: <TextStyle>[
          // Stroked text as border.
          .new(
            color: switch (color) {
              LayeredTextColor.primary => cs.primaryContainer,
              LayeredTextColor.tertiary => cs.tertiaryContainer,
            },
            fontWeight: .w900,
          ),
          // Solid text as fill.
          .new(
            color: switch (color) {
              LayeredTextColor.primary => cs.primaryFixedDim,
              LayeredTextColor.tertiary => cs.tertiaryFixedDim,
            },
            fontWeight: .w300,
          ),
        ].select((s, _) => Text(data, style: s, maxLines: maxLines)).toList(),
      ),
    );
  }
}

enum LayeredTextColor { primary, tertiary }
