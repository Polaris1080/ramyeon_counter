// Package
import 'package:flutter/material.dart';

abstract class const ViewerChipBase({super.key}) extends StatelessWidget {
  /// Outer padding.
  @protected
  EdgeInsets get padding => const .all(0);

  /// Inner padding.
  @protected
  EdgeInsets get labelPadding => const .all(0);
}
