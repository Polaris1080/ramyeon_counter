// Package
import 'package:flutter/material.dart';

// Base
import 'base/rating_widget_base.dart';

class const RatingSelecter(final ValueNotifier<int> ratingNotifier, {super.key})
    extends RatingWidgetBase {
  // 一旦コメントアウト（正常なはず）
  // this : assert(
  //       0 <= ratingNotifier.value &&
  //           ratingNotifier.value <= RatingWidgetBase.max,
  //     );

  @override
  Widget starParts(int index) {
    final rate = index + 1;
    return ValueListenableBuilder<int>(
      valueListenable: ratingNotifier,
      builder: (context, rating, _) => RatingStarButton(
        evaluation: () => rate <= rating ? .full : .none,
        onPressed: () => ratingNotifier.value = rate,
      ),
    );
  }
}
