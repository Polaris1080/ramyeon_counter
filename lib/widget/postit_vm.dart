part of 'postit.dart';

class PostitViewModel extends ChangeNotifier {
  PostitViewModel(BuildContext context, Color? color, Size size)
    : _color = switch (color) {
        Color color => ColorScheme.fromSeed(seedColor: color),
        _ => ColorScheme.of(context),
      }.primaryFixed,
      _size = size;

  /* Color */
  Color get color => _color;
  final Color _color;

  /* Size */
  double get width => _size.width;
  double get height => _size.height;
  final Size _size;
}
