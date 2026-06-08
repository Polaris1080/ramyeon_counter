import '../rating_widget_base.dart';
import 'package:darq/darq.dart';
import 'package:flutter/material.dart';

class RatingSelecter extends RatingSelecterBase {
  RatingSelecter(this.ratingNotifier, {super.key})
    : assert(1 <= ratingNotifier.value && ratingNotifier.value <= 10);

  final ValueNotifier<int> ratingNotifier;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        for (int row in RangeIterable(0, items ~/ _perRow))
          Row(
            children: [
              for (int rate
                  in RatingSelecterBase.range
                      .skip(_perRow * row)
                      .take(_perRow))
                ValueListenableBuilder<int>(
                  valueListenable: ratingNotifier,
                  builder: (_, rating, _) {
                    return IconButton(
                      icon: rate <= rating
                          ? RatingWidgetBase.fullStar
                          : RatingWidgetBase.noneStar,
                      onPressed: () => ratingNotifier.value = rate,
                      constraints: const BoxConstraints(),
                      padding: RatingSelecterBase.iconPadding,
                    );
                  },
                ),
            ],
          ),
      ],
    );
  }

  static const items = RatingWidgetBase.items,
      _perRow = RatingWidgetBase.perRow;
}
