part of 'postit.dart';

class PostitViewModel extends ChangeNotifier {
  PostitViewModel(
    BuildContext context, {
    required Size size, // 大きさ
    Color? color, // 色
  }) : _defaultColor = ColorScheme.of(context).primaryFixed,
       _overrideColor = color != null
           ? ColorScheme.fromSeed(seedColor: color).primaryFixed
           : null,
       _size = size;

  /* Color */
  /// 色
  @OneWay()
  Color get color => _overrideColor ?? _defaultColor;
  set overrideColor(Color? value) {
    if (_overrideColor == value) {
      _overrideColor = value;
      notifyListeners();
    }
  }

  /* Size */
  /// 横
  @OneTime()
  double get width => _size.width;

  /// 縦
  @OneTime()
  double get height => _size.height;

  final Color _defaultColor;
  Color? _overrideColor;
  final Size _size;
}
