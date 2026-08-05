// Base
import 'custom_app_bar_base.dart';
// Package
import 'package:flutter/material.dart';

class DefaultAppBar extends CustomAppBarBase {
  DefaultAppBar(
    super.context,
    String data, {
    super.key,
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
