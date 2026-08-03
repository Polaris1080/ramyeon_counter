part of 'image_background.dart';

class ImageBackgroundViewModel extends ChangeNotifier {
  ImageBackgroundViewModel(String path) : _path = path;

  /// 保存場所(Asset)
  String get path => _path;

  final String _path;
}
