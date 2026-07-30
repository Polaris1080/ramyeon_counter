// Package
import 'package:flutter/material.dart';

class BarcodeChip extends ActionChip {
  /* Setting */
  static const _defaultWidth = 135.0;

  BarcodeChip(
    String data, {
    super.key,
    double chipWidth = _defaultWidth,
    Function()? onPressed,
  }) : super(
         label: SizedBox(
           width: chipWidth,
           child: Text(data, textAlign: .center),
         ),
         padding: EdgeInsets.all(0),
         onPressed: onPressed ?? () {},
       );
}
