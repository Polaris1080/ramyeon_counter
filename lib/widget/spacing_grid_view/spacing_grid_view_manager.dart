part of 'spacing_grid_view.dart';

class SpacingGridViewManager {
  static const _minVerticalSpacing = 10.0, _minHorizontalSpacing = 5.0;

  SpacingGridViewManager(double windowWidth) : _windowWidth = windowWidth {
    crossAxisCount = _calculateCrossAxisCount();
    horizontalSpacing =
        (_windowWidth - crossAxisCount * StockPostit.size) /
        (crossAxisCount + 1); // 両端＋列間
    verticalSpacing = min(
      // 最低値
      max(horizontalSpacing, _minVerticalSpacing),
      // 最高値
      crossAxisCount * _minHorizontalSpacing,
    );
  }

  /// 画面の横幅
  final double _windowWidth;

  /// [GridView]の列数
  late final int crossAxisCount;
  int _calculateCrossAxisCount({int c = 1}) =>
      StockPostit.size * c + _minHorizontalSpacing * (c + 1) < _windowWidth
      ? _calculateCrossAxisCount(c: ++c)
      : c - 1;

  /// 縦の間隔
  late final double verticalSpacing;

  /// 横の間隔
  late final double horizontalSpacing;

  /// 外
  EdgeInsets get gridviewPadding => EdgeInsets.symmetric(
    vertical: verticalSpacing,
    horizontal: horizontalSpacing,
  );

  /// 内
  SliverGridDelegateWithMaxCrossAxisExtent get gridviewDelegate => .new(
    maxCrossAxisExtent: StockPostit.size.toDouble(),
    mainAxisSpacing: verticalSpacing,
    crossAxisSpacing: horizontalSpacing,
    mainAxisExtent: StockPostit.size.toDouble(),
  );

  /// エラー対策用：[GridView]が表示できる横幅があるか？
  bool get gridviewVisible =>
      _windowWidth > StockPostit.size + _minHorizontalSpacing * 2;
}
