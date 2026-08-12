// Package
import 'package:darq/darq.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

abstract class RatingWidgetBase extends StatelessWidget {
  const RatingWidgetBase({super.key}) : assert(_items % _rows == 0);

  /// 全体の個数
  static const _items = 10;

  /// 列数
  static const _rows = 2;

  /// [RatingStarType.full]
  static final fullStar = Icon(fullStarIcon, color: fullStarColor);
  static final fullStarColor = Colors.amber[700];
  static const fullStarIcon = Icons.star;

  /// [RatingStarType.half]
  static final halfStar = Icon(halfStarIcon, color: halfStarColor);
  static final halfStarColor = Colors.amber[900];
  static const halfStarIcon = Icons.star_half;

  /// [RatingStarType.none]
  static final noneStar = Icon(noneStarIcon, color: noneStarColor);
  static final noneStarColor = Colors.black;
  static const noneStarIcon = Icons.star_border;

  static final iconPadding = EdgeInsetsGeometry.all(4);

  /* Frame */
  @nonVirtual
  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: .start,
      runAlignment: .center,
      children: [
        ...RangeIterable(0, _items)
            .batch(_items ~/ _rows)
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
}

enum RatingStarType { full, half, none }
