// Package
import 'package:darq/darq.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

abstract class RatingWidgetBase extends StatelessWidget {
  /* Setting */
  static const items = 10, min = 1, max = 10, _rows = 2;

  const RatingWidgetBase({super.key}) : assert(items % _rows == 0);

  /* Frame */
  @nonVirtual
  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: .start,
      runAlignment: .center,
      children: [
        ...RangeIterable(0, items)
            .batch(items ~/ _rows)
            .select(
              (row, _) => Row(
                mainAxisSize: .min,
                children: [...row.select((rate, _) => starParts(rate))],
              ),
            ),
      ],
    );
  }

  @mustBeOverridden
  Widget starParts(int index);

  /* Star */
  Icon star({required RatingStarType type}) => switch (type) {
    .full => Icon(Icons.star, color: Colors.amber[700]),
    .half => Icon(Icons.star_half, color: Colors.amber[900]),
    .none => Icon(Icons.star_border, color: Colors.black),
  };

  IconButton starButton({
    required RatingStarType Function() evaluation,
    required void Function()? onPressed,
  }) => IconButton(
    icon: star(type: evaluation()),
    onPressed: onPressed,
    constraints: const BoxConstraints(),
    padding: EdgeInsetsGeometry.all(4),
  );
}

enum RatingStarType { full, half, none }
