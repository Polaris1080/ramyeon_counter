// Package
import 'dart:math';
import 'package:flutter/material.dart';
// Widget
import 'package:ramyeon_counter/widget/layered_text.dart';
// Other
import 'package:ramyeon_counter/page/home_page_vm.dart';

class HomeAppBar extends CustomAppBarBase {
  HomeAppBar(super.context, HomePageViewModel vm, {super.key, super.actions})
    : super(
        // 仕様：ScaffoldのAppBarにはListenableBuilderが入らない為
        title: ListenableBuilder(
          listenable: vm,
          builder: (context, _) {
            final windowWidth = MediaQuery.of(context).size.width;
            return vm.isCatalogMode
                ? Text(
                    switch (windowWidth) {
                      > 270 => '在庫一覧',
                      _ => '',
                    },
                    style: TextStyle(
                      // [300:20, 330:22, 360:24...]
                      fontSize: min(max((windowWidth ~/ 30) * 2, 20), 32),
                    ),
                    overflow: .visible,
                  )
                : LayeredText(
                    switch (windowWidth) {
                      > 320 => 'Ramyeon Counter',
                      > 270 => 'Ramyeon',
                      _ => '',
                    },
                    color: .tertiary,
                    // [300:16, 315:17, 330:18...]
                    fontSize: min(max(((windowWidth ~/ 15) - 4), 16), 36),
                    overflow: .visible,
                  );
          },
        ),
        centerTitle: MediaQuery.of(context).size.width >= 360,
      );
}

class DefaultAppBar extends CustomAppBarBase {
  DefaultAppBar(
    super.context,
    String data, {
    super.key,
    Color? overrideColor,
    super.centerTitle,
    super.actions,
  }) : super(
         title: Baseline(
           // テキスト上下調整
           baseline: switch (MediaQuery.of(context).size.width) {
             > 300 => 30,
             _ => 22.5,
           },
           baselineType: .ideographic,
           child: Text(
             data,
             style: TextStyle(
               // 文字色
               color: ColorScheme.of(context).onPrimary,
               // フォント
               fontFamily: 'ZenKakuGothicNew',
               // フォントサイズ
               fontSize: switch (MediaQuery.of(context).size.width) {
                 > 300 => 30,
                 _ => 24,
               },
               // ふとさ
               fontWeight: FontWeight.w300,
             ),
             overflow: TextOverflow.fade,
           ),
         ),
       );
}

abstract class CustomAppBarBase extends AppBar {
  CustomAppBarBase(
    BuildContext context, {
    super.key,
    required super.title,
    required super.centerTitle,
    required super.actions,
  });
}
