part of 'loading_progress_indicator.dart';

class LoadingProgressIndicatorViewModel extends ChangeNotifier {
  LoadingProgressIndicatorViewModel(
    BuildContext context,
    Color? color,
    Duration? duration,
  ) : _color = switch (color) {
        Color color => ColorScheme.fromSeed(seedColor: color),
        _ => ColorScheme.of(context),
      }.tertiary,
      _duration = duration ?? const Duration();

  /* Color */
  Color get color => _color;
  final Color _color;

  /* Delay */
  Future get delay => Future.delayed(_duration);
  final Duration _duration;
}
