// Package
import 'package:flutter/material.dart';
// Partical
part 'image_background_vm.dart';

class ImageBackground extends StatelessWidget {
  /// Background(image)
  ImageBackground({super.key, required String path, this.child})
    : vm = .new(path);

  /// BackGround(cork)
  ImageBackground.cork({super.key, this.child})
    : vm = .new('assets/images/cork.png');

  /// BackGround(paper)
  ImageBackground.paper({super.key, this.child})
    : vm = .new('assets/images/paper.png');

  final ImageBackgroundViewModel vm;

  /* Argument */
  @protected
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(vm.path),
          repeat: ImageRepeat.repeat,
        ),
      ),
      child: child,
    );
  }
}
