import 'package:flutter/material.dart';
import 'package:ramyeon_counter/router.dart';

void main() {
  final colorScheme = ColorScheme.fromSeed(
    dynamicSchemeVariant: .fidelity,
    seedColor: Color.fromARGB(255, 255, 0, 0),
  );

  runApp(
    MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Ramyeon Counter',
      routerDelegate: goRouter.routerDelegate,
      routeInformationParser: goRouter.routeInformationParser,
      routeInformationProvider: goRouter.routeInformationProvider,
      theme: ThemeData(
        appBarTheme: AppBarThemeData(
          // 背景色
          backgroundColor: colorScheme.primary,
          iconTheme: .new(
            // アイコン色
            color: colorScheme.tertiaryContainer,
          ),
          titleTextStyle: .new(
            // 文字色
            color: colorScheme.onPrimary,
            // フォント
            fontFamily: 'ZenKakuGothicNew',
            // ふとさ
            fontWeight: FontWeight.w300,
          ),
        ),
        // 色彩
        colorScheme: colorScheme,
        textTheme: .new()
      ),
    ),
  );
}
