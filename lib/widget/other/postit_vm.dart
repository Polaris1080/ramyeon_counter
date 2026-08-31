part of 'postit.dart';

class PostitViewModel(
  final BuildContext _context, {
  required final Size _size,
  var Color? _overrideColor,
}) extends ChangeNotifier {
  /// Indicator [Color].
  @OneWay()
  Color get color => switch (_overrideColor) {
    Color c => ColorScheme.fromSeed(seedColor: c),
    _ => ColorScheme.of(_context),
  }.primaryFixed;

  /// Change indicator [Color].
  @OneWayToSource()
  set overrideColor(Color? value) {
    if (_overrideColor == value) {
      _overrideColor = value;
      notifyListeners();
    }
  }

  /// [Postit] width.
  @OneTime()
  double get width => _size.width;

  /// [Postit] height.
  @OneTime()
  double get height => _size.height;
}
