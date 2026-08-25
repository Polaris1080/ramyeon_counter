// Package
import 'package:flutter/material.dart';

abstract class const ViewerChipBase({super.key}) extends StatelessWidget {
  @protected
  EdgeInsets get padding => const .all(0);
  @protected
  EdgeInsets get labelPadding => const .all(0);
}
