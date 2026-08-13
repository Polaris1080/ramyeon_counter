// Package
import 'dart:io';
import 'package:flutter/material.dart';
//import 'package:path_provider/path_provider.dart';

class RamyeonImageBaseViewModel extends ChangeNotifier {
  RamyeonImageBaseViewModel({required this.brandId}) {
    // TODO:暫定
    final path = thumbnailPath;
    _imagePath = File(path).existsSync() ? path : null;
    _isImageLoaded = _imagePath != null;
    // thumbnailPath.then(
    //   (path) => {
    //     _imagePath = File(path).existsSync() ? path : null,
    //     _isImageLoaded = _imagePath != null,
    //   },
    // );
  }

  /* Argument */
  final int brandId;

  /* Value */
  bool get isImageLoaded => _isImageLoaded;
  bool _isImageLoaded = false;
  set isImageLoaded(bool value) {
    if (_isImageLoaded != value) {
      _isImageLoaded = value;
      notifyListeners();
    }
  }

  /* Hover */
  bool get isHovering => _isHovering;
  bool _isHovering = false;

  double get hoveringOpacity => isHovering ? 0.8 : 1.0;

  void hoverRegionEnter(_) {
    _isHovering = true;
    notifyListeners();
  }

  void hoverRegionExit(_) {
    _isHovering = false;
    notifyListeners();
  }

  /* Path */
  String? get imagePath => _imagePath;
  String? _imagePath;
  set imagePath(String value) {
    if (_imagePath != value) {
      _imagePath = value;
      notifyListeners();
    }
  }

  bool get isImagePathExist => imagePath != null;

  /* Function */
  // TODO:暫定
  String get thumbnailPath => 'C:/Users/Polar/Documents/${brandId}_full.JPG';
  // Future<String> get thumbnailPath async =>
  //     '${(await getApplicationDocumentsDirectory()).path}/thumbnail/${brandId}_full.JPG';
}
