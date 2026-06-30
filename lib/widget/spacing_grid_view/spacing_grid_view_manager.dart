part of 'spacing_grid_view.dart';

class SpacingGridViewManager {
  static const Size _minSpacing = .new(5.0, 10.0);

  SpacingGridViewManager({required double windowWidth, required Size itemSize})
    : _windowWidth = windowWidth,
      _itemSize = itemSize {
    crossAxisCount = _calculateCrossAxisCount();
    horizontalSpacing =
        (_windowWidth - crossAxisCount * _itemSize.width) /
        (crossAxisCount + 1); // 両端＋列間
    verticalSpacing = min(
      // 最低値
      max(horizontalSpacing, _minSpacing.height),
      // 最高値
      crossAxisCount * _minSpacing.width,
    );
  }

  /// 画面の横幅
  final double _windowWidth;

  /// アイテムの縦幅・横幅
  final Size _itemSize;

  /// [GridView]の列数
  late final int crossAxisCount;
  int _calculateCrossAxisCount({int count = 1}) =>
      _itemSize.width * count + _minSpacing.width * (count + 1) < _windowWidth
      ? _calculateCrossAxisCount(count: ++count)
      : count - 1;

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
    maxCrossAxisExtent: _itemSize.width,
    mainAxisSpacing: verticalSpacing,
    crossAxisSpacing: horizontalSpacing,
    mainAxisExtent: _itemSize.height,
  );

  /// エラー対策用：[GridView]が表示できる横幅があるか？
  bool get gridviewVisible =>
      _windowWidth > _itemSize.width + _minSpacing.width * 2;
}
