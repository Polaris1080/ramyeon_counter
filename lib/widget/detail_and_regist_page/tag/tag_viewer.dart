// Extention
import 'package:ramyeon_counter/utility/extension_type/ramyeon_id.dart';
// Model
import 'package:ramyeon_counter/model/repository/ramyeon_repository.dart';
// Package
import 'package:darq/darq.dart';
import 'package:flutter/material.dart';
// Widget
import 'package:ramyeon_counter/widget/detail_and_regist_page/tag/parts/tag_chip.dart';

class RamyeonTagViewer extends StatelessWidget {
  const RamyeonTagViewer({super.key, required this.id});

  /* Argument */
  final RamyeonId id;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: RamyeonRepository().readTag(id),
      builder: (_, snapshot) => switch (snapshot.data) {
        List<String> tags => Wrap(
          children: [...tags.select((s, _) => TagChip(tag: s))],
        ),
        _ => const SizedBox(),
      },
    );
  }
}
