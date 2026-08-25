// Base
import 'package:ramyeon_counter/widget/detail_and_regist_page/base/chip_based_viewer.dart';
// Package
import 'package:darq/darq.dart';
import 'package:flutter/material.dart';
// Widget
import 'package:ramyeon_counter/widget/detail_and_regist_page/tag/parts/tag_chip.dart';

class TagsViewer extends ChipBasedViewer {
  const TagsViewer({super.key, required this.source});

  /* Argument */
  @protected
  final Set<String> source;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: super.spacing.width,
      runSpacing: super.spacing.height,
      children: source.select((tag, _) => tagChip(context, tag)).toList(),
    );
  }

  /* Widget */
  @protected
  Widget tagChip(BuildContext context, String source) =>
      TagChip(.new(data: source));
}
