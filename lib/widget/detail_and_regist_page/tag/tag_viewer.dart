// Base
import '../base/chip_based_viewer.dart';

// Package
import 'package:flutter/material.dart';

// Parts
import 'chip/tag_chip.dart';

class const TagsViewer({
  super.key,
  @protected required final Set<String> source,
}) extends ChipBasedViewer {
  @override
  List<Widget> get chips =>
      source.map((tag) => tagChip(tag)).toList();

  @protected
  Widget tagChip(String source) =>
      TagChip(vm: .new(data: source));
}
