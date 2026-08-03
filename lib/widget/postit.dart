// Package
import 'package:flutter/material.dart';

class Postit extends StatelessWidget {
  /* Setting */
  static const Size _defaultSize = Size(150.0, 150.0);

  const Postit({super.key, this.color, this.child, this.size = _defaultSize});

  /* Argument */
  @protected
  final Widget? child;

  @protected
  final Color? color;

  @protected
  final Size size;

  @override
  Widget build(BuildContext context) {
    /* Color setting */
    final shadow = BoxShadow(
      color: Colors.grey,
      spreadRadius: 0,
      blurRadius: 3,
      offset: Offset(1, 1),
    );

    return Container(
      width: size.width,
      height: size.height,
      decoration: BoxDecoration(
        boxShadow: [shadow],
        color: switch (color) {
          Color color => ColorScheme.fromSeed(seedColor: color),
          _ => ColorScheme.of(context),
        }.primaryFixed,
      ),
      child: child,
    );
  }
}
