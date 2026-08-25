// Package
import 'package:flutter/material.dart';

// Other
import 'tags_viewer.dart';
import 'register/tag_register_vm.dart';
import 'chip/deletable_tag_chip.dart';

// Partical
part 'register/deletable_tags_viewer.dart';
part 'register/tag_entry.dart';

class RamyeonTagRegister extends StatelessWidget {
  static const _verticalSpacing = 10.0;

  const RamyeonTagRegister(this.vm, {super.key});

  final TagRegisterViewModel vm;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: _verticalSpacing,
      children: [
        TagEntry(vm),
        ListenableBuilder(
          listenable: vm,
          builder: (context, child) =>
              DeletableTagsViewer(vm: vm, source: vm.tag.toSet()),
        ),
      ],
    );
  }
}
