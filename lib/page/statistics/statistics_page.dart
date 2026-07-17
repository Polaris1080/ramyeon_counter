// Model
import 'dart:core';

import 'package:ramyeon_counter/model/repository/rating_repository.dart';
import 'package:ramyeon_counter/model/tag_data.dart';
import 'package:ramyeon_counter/model/context/statistics_data_context.dart';
import 'package:ramyeon_counter/model/context/ramyeon_list_data_context.dart';
// Package
import 'package:darq/darq.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:nil/nil.dart';
// ViewModel
import 'package:ramyeon_counter/page/statistics/statistics_page_vm.dart';
import 'package:ramyeon_counter/utility/extension_methods/em_bool_notifier.dart';
import 'package:ramyeon_counter/utility/extension_methods/em_theme_data.dart';
// Widget
import 'parts/ranking_table.dart';
import 'package:ramyeon_counter/widget/loading_progress_indicator.dart';
import 'package:ramyeon_counter/widget/custom_app_bar.dart';
import 'package:ramyeon_counter/widget/image_background.dart';
// Partical
part 'parts/all_or_year_selector.dart';
part 'parts/all_tag_view_area.dart';
part 'parts/statistics_navigation.dart';
part 'sub_page/eat_pie_chart.dart';
part 'sub_page/stock_bar_chart.dart';
part 'sub_page/ranking_rating_sub_page.dart';
part 'sub_page/ranking_tag_sub_page.dart';

class StatisticsPage extends StatelessWidget {
  /* Setting */
  static const rankingPageHorizontalPadding = 10.0,
      rankingPageVerticalPadding = 10.0,
      rankingPageTableWidth = 300.0;

  StatisticsPage({super.key});

  final StatisticsPageViewModel vm = .new();

  final ValueNotifier<int> selected = .new(0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(context, '統計'),
      body: ImageBackground.paper(
        child: ValueListenableBuilder(
          valueListenable: selected,
          builder: (context, selectedIndex, _) => switch (selectedIndex) {
            1 => Padding(
              padding: const EdgeInsets.all(8.0),
              child: EatPieChart(),
            ),
            2 => Padding(padding: EdgeInsets.all(8.0), child: _StockBarChart()),
            3 => FutureBuilder(
              future: vm.rankingRatingData,
              builder: (context, snapshot) => switch (snapshot.data) {
                Map<String, double> data => RankingRatingSubPage(data),
                _ => DelayedLoadingProgressIndicator.normal(context),
              },
            ),
            _ => FutureBuilder(
              future: vm.rankingTagData,
              builder: (context, snapshot) => switch (snapshot.data) {
                List<TagData> data => RankingTagSubPage(vm, data),
                _ => DelayedLoadingProgressIndicator.normal(context),
              },
            ),
          },
        ),
      ),
      bottomNavigationBar: StatisticsNavigation(selected),
      backgroundColor: ColorScheme.of(context).surface,
    );
  }
}
