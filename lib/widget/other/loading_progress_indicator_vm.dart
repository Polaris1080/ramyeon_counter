part of 'loading_progress_indicator.dart';

class LoadingProgressIndicatorViewModel(
  final BuildContext _context, {
  var Color? _overrideColor,
  Duration? duration,
}) extends ChangeNotifier {
  /// Indicator [Color].
  @OneWay()
  Color get color => switch (_overrideColor) {
    Color c => ColorScheme.fromSeed(seedColor: c),
    _ => ColorScheme.of(_context),
  }.tertiary;

  /// Change indicator [Color].
  @OneWayToSource()
  set overrideColor(Color? value) {
    if (_overrideColor == value) {
      _overrideColor = value;
      notifyListeners();
    }
  }

  /// Delay time.
  @OneTime()
  Future get delay => Future.delayed(_duration);
  final Duration _duration = duration ?? const Duration();
}
