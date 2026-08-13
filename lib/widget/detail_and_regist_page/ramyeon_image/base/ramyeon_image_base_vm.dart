import 'package:flutter/material.dart';

class RamyeonImageBaseViewModel extends ChangeNotifier {
  RamyeonImageBaseViewModel({String? imagePath})
    : _imagePath = imagePath,
      _isImageLoaded = imagePath != null;

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
}
