// Base
import '../base/chip_based_register.dart';

// Package
import 'package:flutter/material.dart';

// Other
import 'tag_viewer.dart';
import 'tag_register_vm.dart';
import 'chip/deletable_tag_chip.dart';

// Partical
part 'register/deletable_tag_viewer.dart';
part 'register/tag_entry.dart';

class const RamyeonTagRegister(final TagRegisterViewModel vm, {super.key})
    extends ChipBasedRegister {
  @override
  List<Widget> get components => [
    // Entry
    TagEntry(vm),
    // Viewer
    ListenableBuilder(
      listenable: vm,
      builder: (context, child) =>
          DeletableTagsViewer(vm: vm, source: vm.source.toSet()),
    ),
  ];
}
