// Package
import 'package:darq/darq.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

// Partial
part 'rating_star.dart';
part 'rating_star_button.dart';
part 'rating_star_type.dart';
part 'rating_star/full_rating_star.dart';
part 'rating_star/half_rating_star.dart';
part 'rating_star/none_rating_star.dart';

abstract class const RatingWidgetBase({super.key}) extends StatelessWidget {
  this : assert(items % _row == 0);

  /// Range min.
  static const min = 1;

  /// Range max
  static const max = 10;

  /// [RatingStar] amount.
  static const items = max - min + 1;

  /// Frame row.
  static const _row = 2;

  /* Frame */
  @nonVirtual
  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: .start,
      runAlignment: .center,
      children: RangeIterable(0, items)
          .batch(items ~/ _row) // items per row(I/R).
          .map(
            (row) => Row(
              mainAxisSize: .min,
              children: row.map((rate) => ratingStar(rate)).toList(),
            ),
          )
          .toList(),
    );
  }

  /// [RatingStar] phenotype.
  @mustBeOverridden
  Widget ratingStar(int index);
}
