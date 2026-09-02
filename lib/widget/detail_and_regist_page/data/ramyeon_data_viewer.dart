// Package
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
// Widget
import 'package:ramyeon_counter/widget/rating/rating_viewer.dart';

import 'ramyeon_data_viewer_vm.dart';

class const RamyeonDataViewer({
  super.key,
  required final RamyeonDataViewerViewModel vm,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final dt = DateFormat('yyyy/MM/dd');
    return FutureBuilder(
      future: vm.load(),
      builder: (context, asyncSnapshot) {
        return Column(
          mainAxisSize: .min,
          spacing: 8,
          children: [
            Text(vm.brand),
            RatingViewer(vm: .new(vm.rate)),
            Text(vm.price),
            Text(
              '${dt.format(DateTime.now().subtract(Duration(days: 365)))}-${dt.format(DateTime.now())}',
            ),
          ],
        );
      },
    );
  }
}
