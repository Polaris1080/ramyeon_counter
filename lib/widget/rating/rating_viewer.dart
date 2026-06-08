import 'rating_widget_base.dart';
import 'rating_viewer_data.dart';
import 'package:darq/darq.dart';
import 'package:flutter/material.dart';

class RatingViewer<T extends num> extends RatingWidgetBase {
  RatingViewer(T rating, {super.key}) : data = RatingViewerData(rating);

  final RatingViewerData data;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        for (int row in RangeIterable(0, items ~/ _perRow))
          Wrap(
            children: [
              for (RatingStarType star
                  in data.star.skip(_perRow * row).take(_perRow))
                switch (star) {
                  .full => RatingWidgetBase.fullStar,
                  .half => RatingWidgetBase.halfStar,
                  .none => RatingWidgetBase.noneStar,
                },
            ],
          ),
      ],
    );
  }

  static const items = RatingWidgetBase.items,
      _perRow = RatingWidgetBase.perRow;
}
