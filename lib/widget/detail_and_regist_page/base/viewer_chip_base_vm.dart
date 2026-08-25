// Package

import 'package:flutter/material.dart';
import 'package:ramyeon_counter/utility/annotations/viewmodel_annotation.dart';

class ViewerChipBaseViewModel({required final String _data})
    extends ChangeNotifier {
  /// Chip text.
  @OneTime()
  String get data => _data;
}
