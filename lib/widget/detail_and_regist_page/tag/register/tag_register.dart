// Package
import 'package:darq/darq.dart';
import 'package:flutter/material.dart';
// ViewModel
import 'package:ramyeon_counter/widget/detail_and_regist_page/tag/register/tag_register_vm.dart';
// Partical
part 'deletable_tag_viewer.dart';
part 'tag_entry.dart';

class RamyeonTagRegister extends StatelessWidget {
  static const _verticalSpacing = 10.0;

  const RamyeonTagRegister(this.vm, {super.key});

  final TagRegisterViewModel vm;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: _verticalSpacing,
      children: [TagEntry(vm), DeletableTagViewer(vm)],
    );
  }
}
