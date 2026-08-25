// Annotation
import 'package:ramyeon_counter/utility/annotations/viewmodel_annotation.dart';

// Base
import 'rating_widget_base.dart';

// Extention
import 'package:ramyeon_counter/utility/extension_methods/em_num.dart';

// Package
import 'package:darq/darq.dart';
import 'package:flutter/material.dart';

// Partial
part 'rating_viewer_vm.dart';

class const RatingViewer<T extends num>({
  super.key,
  required final RatingViewerViewModel vm,
}) extends RatingWidgetBase {
  @override
  Widget starParts(int index) => star(type: vm.star[index]);
}
