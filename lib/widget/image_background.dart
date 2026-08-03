import 'package:flutter/material.dart';

class ImageBackground extends StatelessWidget {
  /// Background(image)
  const ImageBackground({super.key, required this.path, this.child});

  /// BackGround(cork)
  const ImageBackground.cork({super.key, this.child})
    : path = 'assets/images/cork.png';

  /// BackGround(paper)
  const ImageBackground.paper({super.key, this.child})
    : path = 'assets/images/paper.png';

  /* Argument */
  @protected
  final Widget? child;

  /// [AssetImage] image path.
  @protected
  final String path;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(path),
          repeat: ImageRepeat.repeat,
        ),
      ),
      child: child,
    );
  }
}
