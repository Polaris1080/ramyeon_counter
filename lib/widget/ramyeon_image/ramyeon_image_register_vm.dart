import 'package:flutter/material.dart';

import 'ramyeon_image_base_vm.dart';

class RamyeonImageRegisterViewModel extends RamyeonImageViewModelBase {
  /* Hovering */
  bool get isHovering => _isHovering;
  bool _isHovering = false;
  set isHovering(bool value) {
    if (isHovering != value) {
      _isHovering = value;
      notifyListeners();
    }
  }

  /* Image */
  double get imageOpacity => isHovering ? 0.5 : 1.0;

  /* Add-Image Button */
  bool get isButtonVisible => isHovering || imagePath == null;
}
