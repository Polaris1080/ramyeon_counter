/* Package */
import 'package:flutter/material.dart';

class LoadingProgressIndicator extends StatelessWidget {
  const LoadingProgressIndicator({
    super.key,
    this.overrideColor,
    this.duration,
  });

  /* Argument */
  /// [LinearProgressIndicator] color
  @protected
  final Color? overrideColor;

  /// [Future.delayed] time
  @protected
  final Duration? duration;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        progressIndicatorTheme: .new(
          color: switch (overrideColor) {
            Color col => ColorScheme.fromSeed(seedColor: col),
            _ => ColorScheme.of(context),
          }.tertiary,
        ),
      ),
      child: FutureBuilder(
        future: Future.delayed(duration ?? const Duration()),
        builder: (_, snapshot) => switch (snapshot.connectionState) {
          ConnectionState.done => const LinearProgressIndicator(),
          _ => const SizedBox(),
        },
      ),
    );
  }
}
