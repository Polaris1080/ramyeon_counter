part of 'loading_progress_indicator.dart';

class LoadingProgressIndicatorViewModel extends ChangeNotifier {
  LoadingProgressIndicatorViewModel(
    BuildContext context,
    Color? color,
    Duration? duration,
  ) : _defaultColor = ColorScheme.of(context).tertiary,
      _overrideColor = color != null
          ? ColorScheme.fromSeed(seedColor: color).tertiary
          : null,
      _duration = duration ?? const Duration();

  /* Color */
  Color get color => _overrideColor ?? _defaultColor;
  set overrideColor(Color? value) {
    if (_overrideColor == value) {
      _overrideColor = value;
      notifyListeners();
    }
  }

  /* Delay */
  Future get delay => Future.delayed(_duration);
  final Duration _duration;

  final Color _defaultColor;
  Color? _overrideColor;
}
