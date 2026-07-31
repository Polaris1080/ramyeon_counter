// Package
import 'package:darq/darq.dart';
import 'package:flutter/material.dart';
// Widget
import 'package:ramyeon_counter/widget/detail_and_regist_page/tag/parts/tag_chip.dart';

class TagsViewer extends StatelessWidget {
  /* Setting */
  static const _spacing = Size(10.0, 10.0);

  const TagsViewer({super.key, required this.source});

  /* Argument */
  @protected
  final List<String> source;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: _spacing.width,
      runSpacing: _spacing.height,
      children: source.select((tag, _) => tagChip(context, tag)).toList(),
    );
  }

  /* Widget */
  @protected
  TagChip tagChip(BuildContext context, String tag) => TagChip(tag: tag);
}
