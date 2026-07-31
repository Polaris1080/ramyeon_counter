// Package
import 'package:flutter/material.dart';

class TagChip extends ActionChip {
  TagChip(String data, {super.key, Function()? onPressed})
    : super(
        label: Text(data),
        padding: EdgeInsets.all(0),
        onPressed: onPressed ?? () {},
      );
}
