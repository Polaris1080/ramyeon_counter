/* Package */
import 'package:flutter/material.dart';
import 'package:nil/nil.dart';

class LoadingProgressIndicator extends LinearProgressIndicator {
  LoadingProgressIndicator.override(Color overrideColor, {super.key})
    : super(color: ColorScheme.fromSeed(seedColor: overrideColor).tertiary);

  LoadingProgressIndicator.normal(BuildContext context, {super.key})
    : super(color: ColorScheme.of(context).tertiary);
}

class DelayedLoadingProgressIndicator extends StatelessWidget {
  /* MilliSecond（ミリ秒）*/
  const DelayedLoadingProgressIndicator.override(
    Color overrideColor, {
    super.key,
    int milliseconds = 100,
  }) : color = overrideColor,
       time = milliseconds;
  DelayedLoadingProgressIndicator.normal(
    BuildContext context, {
    super.key,
    int milliseconds = 100,
  }) : color = ColorScheme.of(context).tertiary,
       time = milliseconds;

  /* Second（秒）*/
  const DelayedLoadingProgressIndicator.overrideSecond(
    Color overrideColor, {
    super.key,
    int seconds = 1,
  }) : color = overrideColor,
       time = seconds * 1000;
  DelayedLoadingProgressIndicator.normalSecond(
    BuildContext context, {
    super.key,
    int seconds = 1,
  }) : color = ColorScheme.of(context).tertiary,
       time = seconds * 1000;

  /// [LinearProgressIndicator] color
  final Color color;

  /// Delay Time(milliseconds)
  final int time;

  @override
  Widget build(BuildContext context) => FutureBuilder(
    future: Future.delayed(Duration(milliseconds: time)),
    builder: (_, snapshot) => switch (snapshot.connectionState) {
      ConnectionState.done => LinearProgressIndicator(color: color),
      _ => nil,
    },
  );
}
