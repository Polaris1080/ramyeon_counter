import 'rating_widget_base.dart';
import 'package:darq/darq.dart';

class RatingViewerData<T extends num> {
  RatingViewerData(T rating)
    : assert(min <= rating && rating <= max),
      rating = rating.toDouble(),
      star = switch (rating) {
        double r => _range.select<RatingStarType>(
          (x, _) => switch ((r * 2).floor() - (x * 2 + 1)) {
            > 0 => RatingStarType.full,
            0 => RatingStarType.half,
            < 0 => RatingStarType.none,
            _ => throw Error(), // 実際は通らない
          },
        ),
        int r => _range.select<RatingStarType>(
          (x, _) => switch (r - x) {
            > 0 => RatingStarType.full,
            <= 0 => RatingStarType.none,
            _ => throw Error(), // 実際は通らない
          },
        ),
      }.toList();

  /// 評価
  final double rating;

  /// 形状
  final List<RatingStarType> star;

  /// 最低値
  static const int min = 1;

  /// 最大値
  static const int max = 10;

  /// 範囲
  static final RangeIterable _range = RangeIterable(min - 1, max);
}
