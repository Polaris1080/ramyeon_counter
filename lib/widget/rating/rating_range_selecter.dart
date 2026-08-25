// Package
import 'package:flutter/material.dart';
import 'package:ramyeon_counter/utility/extension_methods/em_num.dart';

// Base
import 'rating_widget_base.dart';
// Other
import 'rating_range_selecter_vm.dart';

class RatingRangeSelecter extends RatingWidgetBase {
  const RatingRangeSelecter(this.vm, {super.key});

  final RatingRangeSelecterViewModel vm;

  @override
  Widget starParts(int index) {
    final rate = index + 1;
    return ListenableBuilder(
      listenable: vm,
      builder: (context, _) => starButton(
        evaluation: () =>
            rate.inRange(min: vm.min, max: vm.max) ? .full : .none,
        onPressed: () => vm.ratingChanged(rate),
      ),
    );
  }
}
