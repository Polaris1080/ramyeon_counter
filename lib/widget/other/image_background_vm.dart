part of 'image_background.dart';

class ImageBackgroundViewModel extends ChangeNotifier {
  ImageBackgroundViewModel({required this._path});

  /// BackGround(cork)
  ImageBackgroundViewModel.cork() : _path = 'assets/images/cork.png';

  /// BackGround(paper)
  ImageBackgroundViewModel.paper() : _path = 'assets/images/paper.png';

  /// Asset lacation.
  @OneTime()
  String get location => _path;
  final String _path;
}
