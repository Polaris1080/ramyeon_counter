// Base
import 'dart:io';

import '../base/ramyeon_image_base.dart';
import '../base/ramyeon_image_base_vm.dart';
// Package
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
// Partial
part './ramyeon_image_register_vm.dart';

class RamyeonImageRegister extends RamyeonImageBase {
  // TODO【後で見直す】
  RamyeonImageRegister(
    super.context,
    super.ramyeonId, {
    super.key,
    required this.vm,
    super.imgPath,
    super.packageColor,
  }) : super(viewmodel: vm);

  final RamyeonImageRegisterViewModel vm;

  @override
  Widget overlayArea(BuildContext context) {
    return Center(
      child: ListenableBuilder(
        listenable: vm,
        builder: (_, c) => Visibility(visible: vm.isHovering, child: c!),
        child: actionIcon(
          Icons.add_photo_alternate_outlined,
          onPressed: vm.captureIconPressed,
        ),
      ),
    );
  }
}
