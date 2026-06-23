// Model
import 'package:ramyeon_counter/model/ramyeon_list_data.dart';
// Package
import 'package:flutter/material.dart';
// Widget
import 'package:ramyeon_counter/widget/rating/rating_viewer.dart';

class RamyeonDataViewer extends StatelessWidget {
  const RamyeonDataViewer({super.key, required this.ramyeon});

  final RamyeonListData ramyeon;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: .min,
      spacing: 8,
      children: [
        Text(ramyeon.brand),
        RatingViewer(1),
        Text('価格133円'),
        Text('期間2025/4/31-2026/4/31'),
      ],
    );
  }
}
