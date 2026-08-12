// Package
import 'package:darq/darq.dart';
import 'package:flutter/material.dart';
// Base
import 'rating_widget_base.dart';
// Partial
part 'rating_viewer_vm.dart';

class RatingViewer<T extends num> extends RatingWidgetBase {
  const RatingViewer({super.key, required this.vm});

  final RatingViewerViewModel vm;

  @override
  Widget starParts(int index) => star(type: vm.star[index]);
}
