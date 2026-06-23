// Model
import 'package:ramyeon_counter/model/repository/ramyeon_repository.dart';
// Package
import 'package:flutter/material.dart';
import 'package:nil/nil.dart';

class RamyeonTagViewer extends StatelessWidget {
  const RamyeonTagViewer({super.key, required this.id});

  final int id;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: RamyeonRepository().readTag(id),
      builder: (_, snapshot) {
        return switch (snapshot.data) {
          List<String> tags => Wrap(
            children: [for (var tag in tags) Chip(label: Text(tag))],
          ),
          _ => nil,
        };
      },
      initialData: null,
    );
  }
}
