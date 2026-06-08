import 'package:darq/darq.dart';
import 'package:flutter/material.dart';

abstract class RatingWidgetBase extends StatelessWidget {
  const RatingWidgetBase({super.key}) : assert(items % perRow == 0);

  /// 全体の個数
  static const items = 10;

  /// 一行の個数（分割時）
  static const perRow = 5;

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
}

abstract class RatingSelecterBase extends RatingWidgetBase {
  const RatingSelecterBase({super.key});

  /// 開始位置
  static const oneBased = 1;

  /// 範囲
  static final range = RangeIterable(
    oneBased,
    RatingWidgetBase.items + oneBased,
  );

  static final iconPadding = EdgeInsetsGeometry.all(4);
}

enum RatingStarType { full, half, none }
