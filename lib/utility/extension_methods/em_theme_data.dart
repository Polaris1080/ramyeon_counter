import 'package:flutter/material.dart';

extension EmTheme on ThemeData {
  ThemeData override(Color? overrideColor) {
    if (overrideColor != null) {
      final cs = ColorScheme.fromSeed(
        seedColor: overrideColor,
        dynamicSchemeVariant: .fidelity,
      );
      return copyWith(
        appBarTheme: AppBarThemeData(
          backgroundColor: cs.primary,
          iconTheme: IconThemeData(color: cs.tertiaryContainer),
        ),
        colorScheme: cs,
      );
    } else {
      return this;
    }
  }
}
