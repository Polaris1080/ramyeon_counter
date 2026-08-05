/* Package */
import 'package:flutter/material.dart';
// Partical
part 'loading_progress_indicator_vm.dart';

class LoadingProgressIndicator extends StatelessWidget {
  const LoadingProgressIndicator(
    BuildContext context, {
    super.key,
    required this.vm,
  });

  final LoadingProgressIndicatorViewModel vm;

  @override
  Widget build(BuildContext context) {
    return Theme(
      /* Color setting */
      data: Theme.of(
        context,
      ).copyWith(progressIndicatorTheme: .new(color: vm.color)),
      /* Body */
      child: FutureBuilder(
        future: vm.delay,
        builder: (_, snapshot) => snapshot.connectionState == .done
            ? const LinearProgressIndicator()
            : const SizedBox(),
      ),
    );
  }
}
