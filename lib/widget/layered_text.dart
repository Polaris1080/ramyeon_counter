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

  final String data;
  final LayeredTextColor color;
  final double? fontSize;
  final int? maxLines;
  final TextOverflow? overflow;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return DefaultTextStyle.merge(
      style: TextStyle(
        fontFamily: 'ZenMaruGothic',
        fontSize: fontSize,
        overflow: overflow,
      ),
      child: Stack(
        clipBehavior: .hardEdge,
        children: [
          /* Stroked text as border. */
          Text(
            data,
            style: TextStyle(
              color: switch (color) {
                LayeredTextColor.primary => colorScheme.primaryContainer,
                LayeredTextColor.tertiary => colorScheme.tertiaryContainer,
              },
              fontWeight: .w900,
            ),
            maxLines: maxLines,
          ),
          /* Solid text as fill. */
          Text(
            data,
            style: TextStyle(
              color: switch (color) {
                LayeredTextColor.primary => colorScheme.primaryFixedDim,
                LayeredTextColor.tertiary => colorScheme.tertiaryFixedDim,
              },
              fontWeight: .w300,
            ),
            maxLines: maxLines,
          ),
        ],
      ),
    );
  }
}

enum LayeredTextColor { primary, tertiary }
