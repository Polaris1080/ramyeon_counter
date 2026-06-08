import 'history_card_base.dart';
// Package
import 'package:flutter/material.dart';
// Model
import 'package:ramyeon_counter/model/rating.dart';
// Widget
import 'package:ramyeon_counter/widget/rating/rating_viewer.dart';

class HistoryRatingCard extends HistoryCardBase {
  HistoryRatingCard.showBrand(
    BuildContext context,
    Rating source,
    Color? brandColor, {
    super.key,
  }) : super.showBrand(
         context,
         source.brandId,
         digit: source.rating.floor(),
         headline: _headline,
         date: source.date,
         brandColor: brandColor,
         mainRow: RatingViewer(source.rating),
       );

  HistoryRatingCard.noBrand(
    super.context,
    Rating source,
    Color? brandColor, {
    super.key,
  }) : super.noBrand(
         digit: source.rating.floor(),
         headline: _headline,
         date: source.date,
         brandColor: brandColor,
         mainRow: RatingViewer(source.rating),
       );

  /// 見出し（日付）
  static const _headline = '評価日';
}
