import 'dart:math';

import 'package:flutter/material.dart';
import 'package:nil/nil.dart';
import 'package:ramyeon_counter/model/context/statistics_data_context.dart';
import 'package:ramyeon_counter/model/tag_data.dart';
import 'package:ramyeon_counter/page/statistics/statistics_page_vm.dart';
import 'package:ramyeon_counter/utility/extension_methods/em_int.dart';
import 'package:ramyeon_counter/widget/loading_progress_indicator.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:darq/darq.dart';
import 'package:ramyeon_counter/model/context/ramyeon_list_data_context.dart';
part 'sub_page/eat_pie_chart.dart';
part 'sub_page/stock_bar_chart.dart';
part 'sub_page/ranking_rating_sub_page.dart';
part 'sub_page/ranking_tag_sub_page.dart';

class StatisticsPage extends StatelessWidget {
  StatisticsPage({super.key});

  final StatisticsPageViewModel vm = .new();

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
            2 => Padding(padding: EdgeInsets.all(8.0), child: _StockBarChart()),
            // ｛rating｝ 評価：ランキング
            3 => FutureBuilder(
              future: vm.rankingRatingData,
              builder: (context, snapshot) => switch (snapshot.data) {
                Map<String, double> data => RankingRatingSubPage(data),
                _ => DelayedLoadingProgressIndicator.normal(context),
              },
            ),
            _ => Center(
              child: FutureBuilder(
                future: vm.rankingTagData,
                builder: (context, snapshot) => switch (snapshot.data) {
                  List<TagData> data => RankingTagSubPage(data, vm),
                  _ => DelayedLoadingProgressIndicator.normal(context),
                },
              ),
              //       Text('''
              //   『全体』
              //   タグ：ランキング
              //   タグ：すべて表示
              //   『全期間／年度』
              //   ｛company｝
              //   食べた個数（円グラフ）
              //   ｛stock｝
              //   購入価格：合計
              //   購入価格（ヒストグラム）年／月
              //   ｛rating｝
              //   評価：ランキング
              // '''),
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
                label: 'タグ',
              ),
              NavigationDestination(
                icon: Badge(child: Icon(Icons.notifications_sharp)),
                label: '食べた個数',
              ),
              NavigationDestination(
                icon: Badge(
                  label: Text('2'),
                  child: Icon(Icons.messenger_sharp),
                ),
                label: '購入金額',
              ),
              /* RankingRatingSubPage */
              NavigationDestination(
                icon: Badge(
                  label: Text('2'),
                  child: Icon(Icons.messenger_sharp),
                ),
                label: '評価',
              ),
            ],
          );
        },
      ),
    );
  }
}
