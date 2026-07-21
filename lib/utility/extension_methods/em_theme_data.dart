import 'package:flutter/material.dart';

extension EmTheme on ThemeData {
  ThemeData colorOverride(Color? overrideColor) {
    switch (overrideColor) {
      case _?: // = Not null
        final cs = ColorScheme.fromSeed(
          seedColor: overrideColor,
          dynamicSchemeVariant: .fidelity,
        );
        return copyWith(
          appBarTheme: AppBarThemeData(
            backgroundColor: cs.primary,
            iconTheme: IconThemeData(color: cs.tertiaryContainer),
          ),
          bottomAppBarTheme: .new(color: cs.primaryContainer),
          colorScheme: cs,
        );
      default:
        return this;
    }
  }
}
