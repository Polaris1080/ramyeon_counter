// Package
import 'package:flutter/material.dart';
// Partial
part 'postit_vm.dart';

class Postit extends StatelessWidget {
  /* Setting */
  @protected
  static const Size defaultSize = Size(150.0, 150.0);

  Postit(
    BuildContext context, {
    super.key,
    Color? overrideColor,
    Size size = defaultSize,
    this.child,
  }) : vm = .new(context, overrideColor, size);

  final PostitViewModel vm;

  /* Argument */
  @protected
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: vm.width,
      height: vm.height,
      decoration: BoxDecoration(boxShadow: [_shadow], color: vm.color),
      child: child,
    );
  }

  BoxShadow get _shadow => .new(
    color: Colors.grey,
    spreadRadius: 0,
    blurRadius: 3,
    offset: Offset(1, 1),
  );
}
