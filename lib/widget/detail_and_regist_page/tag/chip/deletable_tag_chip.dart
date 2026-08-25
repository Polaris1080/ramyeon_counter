// Annotation
import 'package:ramyeon_counter/utility/annotations/viewmodel_annotation.dart';

// Base
import 'tag_chip.dart';

// Package
import 'package:flutter/material.dart';

// Partial
part 'deletable_tag_chip_vm.dart';

class const DeletableTagChip({
  super.key,
  required final DeletableTagChipViewModel vm,
}) extends TagChip {
  this : super(vm: vm);

  @override
  Widget build(BuildContext context) {
    return InputChip(
      label: Text(vm.data, textAlign: .end),
      padding: padding,
      onDeleted: vm.onIconPressed,
      onPressed: vm.onBodyPressed,
    );
  }
}
