import 'dart:io';

// Annotation
import 'package:ramyeon_counter/utility/annotations/viewmodel_annotation.dart';

// Package
import 'package:flutter/material.dart';

class RamyeonImageBaseViewModel({required final int brandId})
    extends ChangeNotifier {
  /// Now hovering.
  @OneWay()
  bool get isHovering => _isHovering;
  bool _isHovering = false;

  /// Image opacity while hovering.
  @OneWay()
  double get hoveringOpacity => isHovering ? 0.8 : 1.0;

  /// Image file path.
  @OneWay()
  String? get imagePath => _imagePath;
  late String? _imagePath = File(thumbnailPath).existsSync()
      ? thumbnailPath
      : null;
  @protected
  set imagePath(String value) {
    if (_imagePath != value) {
      _imagePath = value;
      notifyListeners();
    }
  }

  final String thumbnailPath = 'C:/Users/Polar/Documents/${brandId}_full.JPG';

  /// Image file path exist.
  @OneWay()
  bool get isImagePathExist => imagePath != null;

  /// Image loading success.
  @OneWay()
  bool get isImageLoaded => _isImageLoaded;
  late bool _isImageLoaded = _imagePath != null;

  /* Command */
  void hoverRegionEnter(_) {
    _isHovering = true;
    notifyListeners();
  }

  void hoverRegionExit(_) {
    _isHovering = false;
    notifyListeners();
  }

  void imageLoadingErrorOccurred() {
    _isImageLoaded = false;
  }
}
