import 'dart:io';

import 'package:flutter/material.dart';

class RamyeonImageBaseViewModel extends ChangeNotifier {
  RamyeonImageBaseViewModel({required this.brandId}) {
    _imagePath = File(thumbnailPath).existsSync() ? thumbnailPath : null;
    _isImageLoaded = _imagePath != null;
  }

  /* Argument */
  final int brandId;

  /* Value */
  String? get imagePath => _imagePath;
  String? _imagePath;
  set imagePath(String value) {
    if (_imagePath != value) {
      _imagePath = value;
      notifyListeners();
    }
  }

  bool get isHovering => _isHovering;
  bool _isHovering = false;

  bool get isImageLoaded => _isImageLoaded;
  bool _isImageLoaded = false;
  set isImageLoaded(bool value) {
    _isImageLoaded = value;
    notifyListeners();
  }

  void hoverRegionEnter(_) {
    _isHovering = true;
    notifyListeners();
  }

  void hoverRegionExit(_) {
    _isHovering = false;
    notifyListeners();
  }

  /* Function */
  // TODO:仮
  String get thumbnailPath => 'C:/Users/Polar/Documents/${brandId}_full.JPG';
}
