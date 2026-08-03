// Package
import 'package:flutter/material.dart';

class Postit extends StatelessWidget {
  /* Setting */
  @protected
  static const Size defaultSize = Size(150.0, 150.0);

  const Postit({
    super.key,
    this.color,
    this.child,
    this.postitSize = defaultSize,
  });

  /* Argument */
  @protected
  final Widget? child;

  @protected
  final Color? color;

  @protected
  final Size postitSize;

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
      width: postitSize.width,
      height: postitSize.height,
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
