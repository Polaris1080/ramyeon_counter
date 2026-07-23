// Extention
import 'package:darq/darq.dart';
import 'package:ramyeon_counter/utility/extention_type/ramyeon_id.dart';
// Model
import 'package:ramyeon_counter/model/repository/ramyeon_repository.dart';
// Package
import 'package:flutter/material.dart';
import 'package:ramyeon_counter/widget/tag_chip.dart';

class RamyeonTagViewer extends StatelessWidget {
  const RamyeonTagViewer({super.key, required this.id});

  /* Argument */
  final RamyeonId id;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: RamyeonRepository().readTag(id.value),
      builder: (_, snapshot) => switch (snapshot.data) {
        List<String> tags => Wrap(
          children: [...tags.select((tag, _) => TagChip(tag: tag))],
        ),
        _ => const SizedBox(),
      },
      initialData: null,
    );
  }
}
