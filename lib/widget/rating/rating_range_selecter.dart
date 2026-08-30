// Base
import 'base/rating_widget_base.dart';

// Entension
import 'package:ramyeon_counter/utility/extension_methods/em_num.dart';

// Package
import 'package:flutter/material.dart';

// Other
import 'rating_range_selecter_vm.dart';

class const RatingRangeSelecter(
  final RatingRangeSelecterViewModel vm, {
  super.key,
}) extends RatingWidgetBase {
  @override
  Widget starParts(int index) {
    final rate = index + 1;
    return ListenableBuilder(
      listenable: vm,
      builder: (context, _) => RatingStarButton(
        evaluation: () =>
            rate.inRange(min: vm.min, max: vm.max) ? .full : .none,
        onPressed: () => vm.ratingChanged(rate),
      ),
    );
  }
}
