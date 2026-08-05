part of 'loading_progress_indicator.dart';

class LoadingProgressIndicatorViewModel extends ChangeNotifier {
  LoadingProgressIndicatorViewModel(
    BuildContext context, {
    Color? overrideColor,
    Duration? duration,
  }) : _defaultColor = ColorScheme.of(context).tertiary,
       _overrideColor = overrideColor != null
           ? ColorScheme.fromSeed(seedColor: overrideColor).tertiary
           : null,
       _duration = duration ?? const Duration();

  /* Color */
  /// バーの色【OneWay】
  Color get color => _overrideColor ?? _defaultColor;
  set overrideColor(Color? value) {
    if (_overrideColor == value) {
      _overrideColor = value;
      notifyListeners();
    }
  }

  /* Delay */
  /// 遅延時間【OneTime】
  Future get delay => Future.delayed(_duration);
  final Duration _duration;

  final Color _defaultColor;
  Color? _overrideColor;
}
