part of 'spacing_grid_view.dart';

class SpacingGridViewViewModel({
  required final int? _itemCount,
  required final Size _itemSize,
  required final double _windowWidth,
}) extends ChangeNotifier {
  static const _minSpacing = Size(5.0, 10.0);

  /// Item count.
  @OneTime()
  int? get count => _itemCount;

  /// Inner padding.
  @OneTime()
  SliverGridDelegateWithMaxCrossAxisExtent get gridviewDelegate => .new(
    maxCrossAxisExtent: _itemSize.width,
    mainAxisSpacing: _verticalSpacing,
    crossAxisSpacing: _horizontalSpacing,
    mainAxisExtent: _itemSize.height,
  );

  /// Outer padding.
  @OneTime()
  EdgeInsets get gridviewPadding => EdgeInsets.symmetric(
    vertical: _verticalSpacing,
    horizontal: _horizontalSpacing,
  );

  /// エラー対策用：[GridView]が表示できる横幅があるか？
  @OneTime()
  bool get gridviewVisible =>
      _windowWidth > _itemSize.width + _minSpacing.width * 2;

  /* Behind */
  double get _verticalSpacing => _horizontalSpacing.minmax(
    min: _minSpacing.height,
    max: _crossAxisCount * _minSpacing.width,
  );

  double get _horizontalSpacing =>
      (_windowWidth - _crossAxisCount * _itemSize.width) /
      (_crossAxisCount + 1); // 両端＋列間

  /// [GridView] lines.
  late final int _crossAxisCount = _calculateCrossAxisCount();
  int _calculateCrossAxisCount({int count = 1}) =>
      _itemSize.width * count + _minSpacing.width * (count + 1) < _windowWidth
      ? _calculateCrossAxisCount(count: ++count)
      : count - 1;
}
