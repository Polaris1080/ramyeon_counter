import 'package:flutter/material.dart';
import 'package:ramyeon_counter/model/ramyeon.dart';
import 'package:ramyeon_counter/model/ramyeon_list_data.dart';

class RamyeonTagViewer extends StatelessWidget {
  const RamyeonTagViewer({super.key, required this.ramyeon});

  final RamyeonListData ramyeon;

  @override
  Widget build(BuildContext context) {
    List<String> t = switch (ramyeon.tag) {
      String tag => tag.split(','),
      _ => [],
    };

    return Wrap(children: [for (var e in t) Chip(label: Text(e))]);
  }
}
