// Package
import 'package:darq/darq.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

// Partial
part 'rating_star.dart';
part 'rating_star_button.dart';
part 'rating_star_type.dart';
part 'star/full_rating_star.dart';
part 'star/half_rating_star.dart';
part 'star/none_rating_star.dart';

abstract class const RatingWidgetBase({super.key}) extends StatelessWidget {
  this : assert(items % _rows == 0);

  /* Setting */
  static const items = 10, min = 1, max = 10, _rows = 2;

  /* Frame */
  @nonVirtual
  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: .start,
      runAlignment: .center,
      children: RangeIterable(0, items)
          .batch(items ~/ _rows)
          .map(
            (row) => Row(
              mainAxisSize: .min,
              children: row.map((rate) => starParts(rate)).toList(),
            ),
          )
          .toList(),
    );
  }

  @mustBeOverridden
  Widget starParts(int index);
}
