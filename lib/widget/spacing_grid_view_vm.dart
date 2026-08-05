part of 'spacing_grid_view.dart';

class SpacingGridViewViewModel extends ChangeNotifier {
  static const Size _minSpacing = .new(5.0, 10.0);

  SpacingGridViewViewModel({
    required int? itemCount,
    required Size itemSize,
    required double windowWidth,
  }) : _count = itemCount,
       _itemSize = itemSize,
       _windowWidth = windowWidth {
    crossAxisCount = _calculateCrossAxisCount();
  }

  /// 個数【OneTime】
  int? get count => _count;

  /* Spacing */
  /// 内
  SliverGridDelegateWithMaxCrossAxisExtent get gridviewDelegate => .new(
    maxCrossAxisExtent: _itemSize.width,
    mainAxisSpacing: verticalSpacing,
    crossAxisSpacing: horizontalSpacing,
    mainAxisExtent: _itemSize.height,
  );

  /// 外
  EdgeInsets get gridviewPadding => EdgeInsets.symmetric(
    vertical: verticalSpacing,
    horizontal: horizontalSpacing,
  );

  /// エラー対策用：[GridView]が表示できる横幅があるか？【OneTime】
  bool get gridviewVisible =>
      _windowWidth > _itemSize.width + _minSpacing.width * 2;

  /// 縦の間隔
  double get verticalSpacing => min(
    max(horizontalSpacing, _minSpacing.height), // 最低値
    crossAxisCount * _minSpacing.width, // 最高値
  );

  /// 横の間隔
  double get horizontalSpacing =>
      (_windowWidth - crossAxisCount * _itemSize.width) /
      (crossAxisCount + 1); // 両端＋列間

  /// [GridView]の列数
  late final int crossAxisCount;
  int _calculateCrossAxisCount({int count = 1}) =>
      _itemSize.width * count + _minSpacing.width * (count + 1) < _windowWidth
      ? _calculateCrossAxisCount(count: ++count)
      : count - 1;

  final int? _count;
  final Size _itemSize;
  final double _windowWidth;
}
