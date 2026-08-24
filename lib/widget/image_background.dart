// Package
import 'package:flutter/material.dart';
import 'package:ramyeon_counter/utility/annotations/viewmodel_annotation.dart';
// Partical
part 'image_background_vm.dart';

class const ImageBackground({
  super.key,
  required final ImageBackgroundViewModel vm,
  final Widget? _child,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(vm.path),
          repeat: ImageRepeat.repeat,
        ),
      ),
      child: _child,
    );
  }
}
