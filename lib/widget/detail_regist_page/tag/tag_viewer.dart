// Model
import 'package:ramyeon_counter/model/repository/ramyeon_repository.dart';
// Package
import 'package:flutter/material.dart';

class RamyeonTagViewer extends StatelessWidget {
  const RamyeonTagViewer({super.key, required this.ramyeonId});

  final int ramyeonId;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: RamyeonRepository().readTag(ramyeonId),
      builder: (_, snapshot) {
        return switch (snapshot.data) {
          List<String> tags => Wrap(
            children: [for (var tag in tags) Chip(label: Text(tag))],
          ),
          _ => const SizedBox(),
        };
      },
      initialData: null,
    );
  }
}
