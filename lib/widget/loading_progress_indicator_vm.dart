part of 'loading_progress_indicator.dart';

class LoadingProgressIndicatorViewModel(
  final BuildContext _context, {
  Color? overrideColor,
  Duration? duration,
}) extends ChangeNotifier {
  /* Color */
  /// バーの色
  @OneWay()
  Color get color => _overrideColor ?? ColorScheme.of(_context).tertiary;
  set overrideColor(Color? value) {
    if (_overrideColor == value) {
      _overrideColor = value;
      notifyListeners();
    }
  }

  Color? _overrideColor = overrideColor != null
      ? ColorScheme.fromSeed(seedColor: overrideColor).tertiary
      : null;

  /* Delay */
  /// 遅延時間
  @OneTime()
  Future get delay => Future.delayed(_duration);
  final Duration _duration = duration ?? const Duration();
}
