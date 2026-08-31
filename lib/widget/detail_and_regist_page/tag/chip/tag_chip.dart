// Base
import '../../base/viewer_chip_base.dart';
import '../../base/viewer_chip_base_vm.dart';

// Package
import 'package:flutter/material.dart';

// Partical
part 'tag_chip_vm.dart';

class const TagChip({super.key, required final TagChipViewModel vm})
    extends ViewerChipBase {
  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(vm.data, textAlign: .end),
      padding: padding,
    );
  }
}
