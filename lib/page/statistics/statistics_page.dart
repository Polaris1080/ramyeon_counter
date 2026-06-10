import 'package:flutter/material.dart';
import 'package:ramyeon_counter/page/statistics/graph/eat_pie_chart.dart';
import 'package:ramyeon_counter/page/statistics/graph/stock_bar_chart.dart';

class StatisticsPage extends StatelessWidget {
  StatisticsPage({super.key});

  final ValueNotifier<int> counter = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sample App')),
      body: ValueListenableBuilder(
        valueListenable: counter,
        builder: (context, value, child) {
          return switch (value) {
            // 『全期間／年度』｛company｝食べた個数（円グラフ）
            1 => Padding(
              padding: const EdgeInsets.all(8.0),
              child: EatPieChart(),
            ),
            // ｛stock｝  購入価格：合計 購入価格（ヒストグラム）
            2 => Padding(padding: EdgeInsets.all(8.0), child: StockBarChart()),
            // ｛rating｝ 評価：ランキング
            3 => Padding(padding: EdgeInsets.all(8.0)),
            _ => Center(
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
        '''),
            ),
          };
        },
      ),

      bottomNavigationBar: ValueListenableBuilder(
        valueListenable: counter,
        builder: (context, value, child) {
          return NavigationBar(
            onDestinationSelected: (int index) {
              counter.value = index;
            },
            indicatorColor: Colors.amber,
            selectedIndex: value,
            destinations: const <Widget>[
              NavigationDestination(
                selectedIcon: Icon(Icons.home),
                icon: Icon(Icons.home_outlined),
                label: 'Home',
              ),
              NavigationDestination(
                icon: Badge(child: Icon(Icons.notifications_sharp)),
                label: 'Company',
              ),
              NavigationDestination(
                icon: Badge(
                  label: Text('2'),
                  child: Icon(Icons.messenger_sharp),
                ),
                label: 'Stock',
              ),
              NavigationDestination(
                icon: Badge(
                  label: Text('2'),
                  child: Icon(Icons.messenger_sharp),
                ),
                label: 'Rating',
              ),
            ],
          );
        },
      ),
    );
  }
}
