// Package
import 'package:flutter/material.dart';
// Partial
part 'postit_vm.dart';

class Postit extends StatelessWidget {
  /* Setting */
  @protected
  static const Size defaultSize = Size(150.0, 150.0);

  const Postit({super.key, required this.vm, this.child});

  final PostitViewModel vm;

  /* Argument */
  @protected
  final Widget? child;

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
      child: child,
    );
  }
}
