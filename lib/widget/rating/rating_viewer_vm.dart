part of 'rating_viewer.dart';

class RatingViewerViewModel<T extends num>(@visibleForTesting final T rating)
    extends ChangeNotifier {
  this
    : assert(
        rating.inRange(
          min: RatingWidgetBase.min as T,
          max: RatingWidgetBase.max as T,
        ),
      );

  /// 形状
  @OneTime()
  List<RatingStarType> get star => _star;
  final List<RatingStarType> _star = switch (rating) {
    double r =>
      RangeIterable.count(1, RatingWidgetBase.items, step: 2)
          .map((s) => (r * 2).floor() - s)
          .select<RatingStarType>(
            (s, _) => switch (s) {
              > 0 => .full,
              0 => .half,
              < 0 => .none,
              _ => throw UnimplementedError(),
            },
          ),
    int r => RangeIterable.count(
      0,
      RatingWidgetBase.items,
    ).map((m) => r - m).select<RatingStarType>((x, _) => x > 0 ? .full : .none),
  }.toList();
}
