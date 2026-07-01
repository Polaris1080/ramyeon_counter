import 'package:darq/darq.dart';
import 'package:flutter/material.dart';
import 'package:ramyeon_counter/model/context/statistics_data_context.dart';
import 'package:ramyeon_counter/model/context/tag_data_context.dart';
import 'package:ramyeon_counter/model/rating.dart';
import 'package:ramyeon_counter/model/tag_data.dart';

class StatisticsPageViewModel extends ChangeNotifier {
  //StatisticsPageViewModel() {}

  /// [Rating] 評価：ランキング
  Future<Map<String, double>> get rankingRatingData async =>
      (_rankingRatingData ??= await StatisticsDataContext()
          .readRankingRatingData()
          .then((result) => _rankingRatingData = result))!;
  Map<String, double>? _rankingRatingData;

  Future<List<TagData>> get rankingTagData async =>
      (_rankingTagData ??= await TagDataContext().readRankingTagData().then(
        (result) => _rankingTagData = result,
      ))!;

  List<TagData>? _rankingTagData;
}
