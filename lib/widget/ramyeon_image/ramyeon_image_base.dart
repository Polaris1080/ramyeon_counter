import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ramyeon_counter/model/ramyeon.dart';
import 'ramyeon_image_base_vm.dart';

abstract class RamyeonImageBase extends StatelessWidget {
  RamyeonImageBase(this.vm,Ramyeon? ramyeon, {super.key})
    : packageColor = ramyeon != null && ramyeon.packageColor != null
          ? Color(ramyeon.packageColor!)
          : null {
    if (ramyeon != null) {
      if (File(
        'C:/Users/Polar/Documents/${ramyeon.id}_full.JPG',
      ).existsSync()) {
        vm.imagePath = 'C:/Users/Polar/Documents/${ramyeon.id}_full.JPG';
      }
    }
  }

  final RamyeonImageViewModelBase vm;

  final Color? packageColor;
}
