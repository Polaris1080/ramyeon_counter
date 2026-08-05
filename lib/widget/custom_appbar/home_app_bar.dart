// Base
import 'custom_app_bar_base.dart';
// Package

import 'package:flutter/material.dart';
import 'package:ramyeon_counter/page/home/home_page.dart';
import 'package:ramyeon_counter/utility/extension_methods/em_int.dart';
import 'package:ramyeon_counter/widget/layered_text.dart';

class HomeAppBar extends CustomAppBarBase {
  HomeAppBar(super.context, HomePageViewModel vm, {super.key, super.actions})
    : super(
        // 仕様：ScaffoldのAppBarにはListenableBuilderが入らない為
        title: ListenableBuilder(
          listenable: vm,
          builder: (context, _) {
            final windowWidth = MediaQuery.of(context).size.width;
            return switch (vm.isCatalogMode) {
              true => Text(
                switch (windowWidth) {
                  > 270 => '在庫一覧',
                  _ => '',
                },
                style: TextStyle(
                  // [300:20, 330:22, 360:24...]
                  fontSize: (windowWidth ~/ 30).minmax(20, 32).toDouble(),
                ),
                overflow: .visible,
              ),
              false => LayeredText(
                vm: .new(
                  context,
                  title: switch (windowWidth) {
                    > 320 => 'Ramyeon Counter',
                    > 270 => 'Ramyeon',
                    _ => '',
                  },
                  color: .tertiary,
                  // [300:16, 315:17, 330:18...]
                  fontSize: ((windowWidth ~/ 15) - 4).minmax(16, 36).toDouble(),
                  overflow: .visible,
                ),
              ),
            };
          },
        ),
        centerTitle: MediaQuery.of(context).size.width >= 360,
      );
}
