// Package
import 'package:flutter/material.dart';
// Base
import 'rating_widget_base.dart';

class RatingSelecter extends RatingWidgetBase {
  RatingSelecter(this.ratingNotifier, {super.key})
    : assert(0 <= ratingNotifier.value && ratingNotifier.value <= 10);

  final ValueNotifier<int> ratingNotifier;

  @override
  Widget starParts(int index) {
    final rate = index + 1;
    return ValueListenableBuilder<int>(
      valueListenable: ratingNotifier,
      builder: (_, rating, _) => IconButton(
        icon: rate <= rating
            ? RatingWidgetBase.fullStar
            : RatingWidgetBase.noneStar,
        onPressed: () => ratingNotifier.value = rate,
        constraints: const BoxConstraints(),
        padding: RatingWidgetBase.iconPadding,
      ),
    );
  }
}
