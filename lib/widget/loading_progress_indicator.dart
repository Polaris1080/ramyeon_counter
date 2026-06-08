import 'package:flutter/material.dart';

class LoadingProgressIndicator extends LinearProgressIndicator {
  LoadingProgressIndicator.override(Color overrideColor, {super.key})
    : super(color: ColorScheme.fromSeed(seedColor: overrideColor).tertiary);

  LoadingProgressIndicator.normal(BuildContext context, {super.key})
    : super(color: ColorScheme.of(context).tertiary);
}
