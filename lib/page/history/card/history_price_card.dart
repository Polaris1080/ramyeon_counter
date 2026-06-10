// Base
import 'history_card_base.dart';
// Package
import 'package:flutter/material.dart';
// Model
import 'package:ramyeon_counter/model/stock.dart';

class HistoryPriceCard extends HistoryCardBase {
  HistoryPriceCard.showBrand(
    BuildContext context,
    Stock source,
    int index,
    Color? brandColor, {
    super.key,
  }) : super.showBrand(
         context,
         source.brandId,
         digit: index,
         headline: _headline,
         date: source.purchaseDate,
         brandColor: brandColor,
         mainRow: _mainRow(context, source.price),
       );

  HistoryPriceCard.noBrand(
    super.context,
    Stock source,
    int index,
    Color? brandColor, {
    super.key,
  }) : super.noBrand(
         digit: index,
         headline: _headline,
         date: source.purchaseDate,
         brandColor: brandColor,
         mainRow: _mainRow(context, source.price),
       );

  static Widget _mainRow(BuildContext context, int price) {
    return Text(
      switch (HistoryCardBase.displayWidth(context)) {
        > 1080 / 5 => '価格：$price円', // 216
        _ => '$price円',
      },
      style: Theme.of(context).textTheme.titleMedium,
      maxLines: 1,
      overflow: .clip,
    );
  }

  /// 見出し（日付）
  static const _headline = '購入日';
}
