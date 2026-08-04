// Package
import 'package:flutter/material.dart';
// Partical
part 'image_background_vm.dart';

class ImageBackground extends StatelessWidget {
  const ImageBackground({super.key, required this.vm, this.child});

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
