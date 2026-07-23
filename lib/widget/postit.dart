// Package
import 'package:flutter/material.dart';

class Postit extends StatelessWidget {
  const Postit({super.key, this.color, this.child});

  final Widget? child;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    /* Postit */
    return Container(
      width: 150,
      height: 150,
      decoration: BoxDecoration(
        boxShadow: [
          .new(
            color: Colors.grey,
            spreadRadius: 0,
            blurRadius: 3,
            offset: Offset(1, 1),
          ),
        ],
        color: switch (color) {
          Color color => ColorScheme.fromSeed(seedColor: color),
          _ => ColorScheme.of(context),
        }.primaryFixed,
      ),
      child: child,
    );
  }
}
