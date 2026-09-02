part of 'rating_viewer.dart';

class RatingViewerViewModel<T extends num>(@visibleForTesting final T rating)
    extends ChangeNotifier {
  this : assert(rating.inRange(min: 0.0 as T, max: RatingWidgetBase.max as T));

  /// 形状
  @OneTime()
  List<RatingStarType> get star => _star;
  final List<RatingStarType> _star = switch (rating) {
    double r =>
      Iterable.generate(RatingWidgetBase.items, (int count) => count * 2 + 1)
          .map((s) => (r * 2).floor() - s)
          .map<RatingStarType>(
            (s) => switch (s) {
              > 0 => .full,
              0 => .half,
              < 0 => .none,
              _ => throw UnimplementedError(),
            },
          ),
    int r => Iterable.generate(
      RatingWidgetBase.items,
      (int count) => count,
    ).map((m) => r - m).map<RatingStarType>((x) => x > 0 ? .full : .none),
  }.toList();
}
