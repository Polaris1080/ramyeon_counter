import 'package:darq/darq.dart';
import 'package:flutter/material.dart';
import 'package:ramyeon_counter/model/context/statistics_data_context.dart';
import 'package:ramyeon_counter/model/rating.dart';

class StatisticsPageViewModel extends ChangeNotifier {
  //StatisticsPageViewModel() {}

  /// [Rating] 評価：ランキング
  Future<Map<String, double>> get rankingRatingData async =>
      (_rankingRatingData ??= await StatisticsDataContext()
          .readRankingRatingData()
          .then((result) => _rankingRatingData = result))!;
  Map<String, double>? _rankingRatingData;
}
