part of 'postit.dart';

class PostitViewModel extends ChangeNotifier {
  PostitViewModel(BuildContext context, Color? color, Size size)
    : _defaultColor = ColorScheme.of(context).primaryFixed,
      _overrideColor = color != null
          ? ColorScheme.fromSeed(seedColor: color).primaryFixed
          : null,
      _size = size;

  /* Color */

  Color get color => _overrideColor ?? _defaultColor;
  final Color _defaultColor;
  Color? _overrideColor;
  set overrideColor(Color? value) {
    if (_overrideColor == value) {
      _overrideColor = value;
      notifyListeners();
    }
  }

  /* Size */
  double get width => _size.width;
  double get height => _size.height;
  final Size _size;
}
