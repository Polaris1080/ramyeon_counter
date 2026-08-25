// Base
import 'custom_app_bar_base.dart';

// Extention-method
import 'package:ramyeon_counter/utility/extension_methods/em_int.dart';
// Package
import 'package:flutter/material.dart';
// Widget
import 'package:ramyeon_counter/widget/layered_text.dart';
// Other
import 'package:ramyeon_counter/page/home/home_page.dart';

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
                  fontSize: (windowWidth ~/ 30)
                      .minmax(min: 20, max: 32)
                      .toDouble(),
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
                  fontSize: ((windowWidth ~/ 15) - 4)
                      .minmax(min: 16, max: 36)
                      .toDouble(),
                  overflow: .visible,
                ),
              ),
            };
          },
        ),
        centerTitle: MediaQuery.of(context).size.width >= 360,
      );
}
