import 'package:flutter/material.dart';

class ImageBackground extends StatelessWidget {
  /// Background(image)
  const ImageBackground({super.key, required String path, Widget? child})
    : _child = child,
      _path = path;

  /// BackGround(cork)
  const ImageBackground.cork({super.key, Widget? child})
    : _child = child,
      _path = 'assets/images/cork.png';

  /// BackGround(paper)
  const ImageBackground.paper({super.key, Widget? child})
    : _child = child,
      _path = 'assets/images/paper.png';

  final Widget? _child;
  final String _path;

  @override
  Widget build(BuildContext context) => Container(
    decoration: BoxDecoration(
      image: DecorationImage(
        image: AssetImage(_path),
        repeat: ImageRepeat.repeat,
      ),
    ),
    child: _child,
  );
}
