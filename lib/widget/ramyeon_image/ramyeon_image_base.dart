import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ramyeon_counter/model/ramyeon.dart';
import 'package:ramyeon_counter/model/ramyeon_list_data.dart';
import 'ramyeon_image_base_vm.dart';

abstract class RamyeonImageBase extends StatelessWidget {
  RamyeonImageBase(this.vm, this.packageColor, int? ramyeonId, {super.key}) {
    if (ramyeonId != null) {
      if (File('C:/Users/Polar/Documents/${ramyeonId}_full.JPG').existsSync()) {
        vm.imagePath = 'C:/Users/Polar/Documents/${ramyeonId}_full.JPG';
      }
    }
  }

  final RamyeonImageViewModelBase vm;

  final Color? packageColor;
}
