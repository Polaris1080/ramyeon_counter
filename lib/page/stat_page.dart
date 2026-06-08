import 'package:flutter/material.dart';

class StatPage extends StatelessWidget {
  const StatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sample App')),
      body: Center(
        child: Text('''
          『全体』
          タグ：ランキング
          タグ：すべて表示
          『全期間／年度』
          ｛company｝
          食べた個数（円グラフ）
          ｛stock｝
          購入価格：合計
          購入価格（ヒストグラム）
          ｛rating｝
          評価：ランキング
          評価／価格（点グラフ）
        '''),
      ),
    );
  }
}
