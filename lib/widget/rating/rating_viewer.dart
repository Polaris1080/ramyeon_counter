// Package
import 'package:flutter/material.dart';
// Base
import 'rating_widget_base.dart';
import 'rating_viewer_data.dart';

class RatingViewer<T extends num> extends RatingWidgetBase {
  RatingViewer(T rating, {super.key}) : data = RatingViewerData(rating);

  final RatingViewerData data;

  @override
  Widget starParts(int index) => switch (data.star[index]) {
    .full => RatingWidgetBase.fullStar,
    .half => RatingWidgetBase.halfStar,
    .none => RatingWidgetBase.noneStar,
  };
}
