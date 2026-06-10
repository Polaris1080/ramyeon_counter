// Package
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
// Model
import 'package:ramyeon_counter/model/ramyeon.dart';
import 'package:ramyeon_counter/model/repository/ramyeon_repository.dart';

abstract class HistoryCardBase extends Card {
  @protected
  HistoryCardBase.showBrand(
    BuildContext context,
    int brandId, {
    super.key,
    required int digit,
    Color? brandColor,
    required String headline,
    required DateTime date,
    required Widget mainRow,
  }) : super(
         child: ListTile(
           leading: _leading(context, digit, brandColor),
           title: mainRow,
           subtitle: FutureBuilder(
             future: RamyeonRepository().read(brandId),
             builder: (_, snapshot) {
               final width = displayWidth(context);
               return Text(
                 switch (snapshot.data) {
                   Ramyeon r =>
                     '${_subtitleDate(width, headline, date)}\n${_subtitleBrand(width, r)}',
                   _ => _subtitleDate(width, headline, date),
                 },
                 style: Theme.of(context).textTheme.bodyMedium,
                 maxLines: 1,
                 overflow: .ellipsis,
               );
             },
             initialData: null,
           ),
           isThreeLine: true,
         ),
       );

  @protected
  HistoryCardBase.noBrand(
    BuildContext context, {
    super.key,
    required int digit,
    Color? brandColor,
    required String headline,
    required DateTime date,
    required Widget mainRow,
  }) : super(
         child: ListTile(
           leading: _leading(context, digit, brandColor),
           title: mainRow,
           subtitle: Text(
             _subtitleDate(displayWidth(context), headline, date),
             style: Theme.of(context).textTheme.bodyMedium,
             maxLines: 1,
             overflow: .ellipsis,
           ),
         ),
       );

  /// 内容
  static ExcludeSemantics _leading(
    BuildContext context,
    int digit,
    Color? overrideColor,
  ) {
    final theme = switch (overrideColor) {
      Color c => Theme.of(context).copyWith(
        colorScheme: ColorScheme.fromSeed(
          seedColor: c,
          dynamicSchemeVariant: .fidelity,
        ),
      ),
      _ => Theme.of(context),
    };
    return ExcludeSemantics(
      child: CircleAvatar(
        foregroundColor: theme.colorScheme.onSecondary,
        backgroundColor: theme.colorScheme.secondary,
        child: Text(
          (digit % 100).toString(),
          style: theme.textTheme.titleMedium!.copyWith(
            color: theme.colorScheme.onPrimary,
          ),
        ),
      ),
    );
  }

  /// 日付（下段）
  static String _subtitleDate(double width, String headline, DateTime date) {
    return switch (width) {
      > 300 => '$headline：${DateFormat('yyyy年MM月dd日').format(date)}',
      _ => DateFormat('yyyy年MM月dd日').format(date),
    };
  }

  /// 品名（下段）
  static String _subtitleBrand(double width, Ramyeon? ramyeon) {
    final headline = '商品名';
    return switch (ramyeon) {
      Ramyeon r when width > 1080 / 2 => '$headline：${r.brand}',
      Ramyeon r => r.brand,
      _ => '',
    };
  }

  @protected
  static double displayWidth(BuildContext context) =>
      MediaQuery.of(context).size.width;
}
