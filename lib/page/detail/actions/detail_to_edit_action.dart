// Model

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DetailToEditAction extends StatelessWidget {
  const DetailToEditAction(this.ramyeonId, this.packageColor, {super.key});

  final int ramyeonId;
  final Color? packageColor;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.edit),
      tooltip: '編集',
      onPressed: () {
        context.push('/detail/edit/$ramyeonId', extra: packageColor);
      },
    );
  }
}
