// Package
import 'package:darq/darq.dart';
import 'package:flutter/material.dart';
// Model
import 'package:ramyeon_counter/models/context/tag_data.dart';
import 'package:ramyeon_counter/models/model/rating.dart';
import 'package:ramyeon_counter/models/context/behind/statistics_data_context.dart';
import 'package:ramyeon_counter/models/context/behind/tag_data_context.dart';

// TODO:cache【余裕があれば】
class StatisticsPageViewModel extends ChangeNotifier {
  /// [Rating] 評価：ランキング
  Future<Map<String, double>> get rankingRatingData async =>
      (_rankingRatingData ??= await StatisticsDataContext()
          .readRankingRatingData()
          .then((result) => _rankingRatingData = result))!;
  Map<String, double>? _rankingRatingData;

  /// [TagData] タグ：ランキング
  Future<List<TagData>> get rankingTagData async =>
      (_rankingTagData ??= await TagDataContext()
          .readRankingTagData(limit: 10)
          .then((result) => _rankingTagData = result))!;
  List<TagData>? _rankingTagData;

  /// [TagData] タグ：すべて表示
  Future<List<TagData>> get allTagData async =>
      (_allTagData ??= await TagDataContext().readAllTagData().then(
        (result) => _allTagData = result,
      ))!;
  List<TagData>? _allTagData;
}
