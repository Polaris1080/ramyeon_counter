import 'dart:io';

// Annotation
import 'package:ramyeon_counter/utility/annotations/viewmodel_annotation.dart';

// Base
import '../base/ramyeon_image_base.dart';
import '../base/ramyeon_image_base_vm.dart';

// Package
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

// Partial
part './ramyeon_image_register_vm.dart';

class const RamyeonImageRegister({
  super.key,
  required final RamyeonImageRegisterViewModel vm,
}) extends RamyeonImageBase {
  this : super(vm);

  @override
  Widget overlayArea(BuildContext context) {
    return Center(
      // Visibility(Hovering)
      child: ListenableBuilder(
        listenable: vm,
        builder: (_, c) => Visibility(visible: vm.isHovering, child: c!),
        // Capture
        child: actionIcon(
          Icons.add_photo_alternate_outlined,
          onPressed: vm.onCaptureButtonPressed,
        ),
      ),
    );
  }
}
