// Annotation
import 'package:ramyeon_counter/utility/annotations/viewmodel_annotation.dart';

// Package
import 'package:flutter/material.dart';

// Partial
part 'postit_vm.dart';

class const Postit({
  super.key,
  required final PostitViewModel vm,
  final Widget? _child,
}) extends StatelessWidget {
  /* Setting */
  @protected
  static const Size defaultSize = Size(150.0, 150.0);

  @override
  Widget build(BuildContext context) {
    /* Widget */
    BoxShadow shadow = .new(
      color: Colors.grey,
      spreadRadius: 0,
      blurRadius: 3,
      offset: Offset(1, 1),
    );

    /* Body */
    return Container(
      width: vm.width,
      height: vm.height,
      decoration: BoxDecoration(boxShadow: [shadow], color: vm.color),
      child: _child,
    );
  }
}
