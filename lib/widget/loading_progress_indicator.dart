/* Package */
import 'package:flutter/material.dart';
// Partical
part 'loading_progress_indicator_vm.dart';

class LoadingProgressIndicator extends StatelessWidget {
  LoadingProgressIndicator(
    BuildContext context, {
    super.key,
    Color? overrideColor,
    Duration? duration,
  }) : vm = .new(context, overrideColor, duration);

  final LoadingProgressIndicatorViewModel vm;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(
        context,
      ).copyWith(progressIndicatorTheme: .new(color: vm.color)),
      child: FutureBuilder(
        future: vm.delay,
        builder: (_, snapshot) => snapshot.connectionState == .done
            ? const LinearProgressIndicator()
            : const SizedBox(),
      ),
    );
  }
}
