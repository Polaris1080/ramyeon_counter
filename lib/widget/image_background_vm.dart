part of 'image_background.dart';

class ImageBackgroundViewModel extends ChangeNotifier {
  ImageBackgroundViewModel({required this._path});

  /// BackGround(cork)
  ImageBackgroundViewModel.cork() : _path = 'assets/images/cork.png';

  /// BackGround(paper)
  ImageBackgroundViewModel.paper() : _path = 'assets/images/paper.png';

  /// 保存場所(Asset)【OneTime】
  String get path => _path;

  final String _path;
}
