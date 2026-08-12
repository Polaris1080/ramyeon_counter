// Package
import 'package:flutter/material.dart';
// Base
import 'rating_widget_base.dart';

class RatingSelecter extends RatingWidgetBase {
  RatingSelecter(this.ratingNotifier, {super.key})
    : assert(
        0 <= ratingNotifier.value &&
            ratingNotifier.value <= RatingWidgetBase.max,
      );

  final ValueNotifier<int> ratingNotifier;

  @override
  Widget starParts(int index) {
    final rate = index + 1;
    return ValueListenableBuilder<int>(
      valueListenable: ratingNotifier,
      builder: (_, rating, _) => starButton(
        evaluation: () => rate <= rating ? .full : .none,
        onPressed: () => ratingNotifier.value = rate,
      ),
    );
  }
}
