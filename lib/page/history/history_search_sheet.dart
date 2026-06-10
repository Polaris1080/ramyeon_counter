// Extention
import 'package:ramyeon_counter/utility/extension_methods/em_theme_data.dart';
// Package
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
// ViewModel
import 'package:ramyeon_counter/page/history/view_model/history_page_vm_base.dart';
import 'package:ramyeon_counter/page/history/view_model/history_price_page_vm.dart';
import 'package:ramyeon_counter/page/history/view_model/history_rating_page_vm.dart';
// Widget
import 'package:ramyeon_counter/page/history/price_range_selecter.dart';
import 'package:ramyeon_counter/widget/rating/selecter/rating_range_selecter.dart';

class HistoryPriceSearchSheet extends HistorySearchSheetBase {
  HistoryPriceSearchSheet(
    HistoryPricePageViewModel super.vm,
    super.heading,
    super.packageColor, {
    super.key,
  }) : super(rangeSearcher: PriceRangeSelecter(vm.priceRange));
}

class HistoryRatingSearchSheet extends HistorySearchSheetBase {
  HistoryRatingSearchSheet(
    HistoryRatingPageViewModel super.vm,
    super.heading,
    super.packageColor, {
    super.key,
  }) : super(rangeSearcher: RatingRangeSelecter(vm.ratingRange));
}

abstract class HistorySearchSheetBase extends StatelessWidget {
  HistorySearchSheetBase(
    this.vm,
    this.heading,
    this.packageColor, {
    super.key,
    required this.rangeSearcher,
  });

  factory HistorySearchSheetBase.getInstance(
    HistoryPageViewModelBase vm,
    Color? packageColor,
  ) {
    return switch (vm) {
      HistoryPricePageViewModel vm => HistoryPriceSearchSheet(
        vm,
        '価格',
        packageColor,
      ),
      HistoryRatingPageViewModel vm => HistoryRatingSearchSheet(
        vm,
        '評価',
        packageColor,
      ),
      _ => throw UnimplementedError(),
    };
  }

  final Color? packageColor;
  final HistoryPageViewModelBase vm;
  final Widget rangeSearcher;

  /// 標目
  final String heading;

  @override
  Widget build(BuildContext context) {
    return
    /* Color change */
    Theme(
      data: Theme.of(context).override(packageColor),
      child: Column(
        spacing: 10,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: [
          /* 1st Row */
          Column(
            children: [
              Text(
                '期間',
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                  decoration: TextDecoration.underline,
                  decorationStyle: .double,
                  fontFamily: 'ZenKakuGothicNew',
                ),
              ),
              ListenableBuilder(
                listenable: vm,
                builder: (context, child) {
                  return Text(
                    '${DateFormat('y/MM/dd').format(vm.dateRange.start)}'
                    ' ~ '
                    '${DateFormat('y/MM/dd').format(vm.dateRange.end)}',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontFamily: 'ZenMaruGothic',
                    ),
                    maxLines: 1,
                    overflow: .ellipsis,
                  );
                },
              ),
            ],
          ),
          /* 2nd Row */
          Column(
            children: [
              Text(
                heading,
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                  decoration: TextDecoration.underline,
                  fontFamily: 'ZenKakuGothicNew',
                ),
              ),
              rangeSearcher,
            ],
          ),
          /* 3rd Row */
          Wrap(
            spacing: 10,
            runSpacing: 10,
            alignment: .center,
            children: [
              OutlinedButton(
                style: buttonStyle,
                child: const Text('リセット'),
                onPressed: () {
                  vm.reset();
                  Navigator.pop(context);
                },
              ),
              OutlinedButton(
                style: buttonStyle,
                child: const Text('検索'),
                onPressed: () {
                  vm.search();
                  Navigator.pop(context);
                },
              ),
              OutlinedButton(
                style: buttonStyle,
                child: const Text('期間設定'),
                onPressed: () async => vm.dateRange = await showDateRangePicker(
                  context: context,
                  initialDateRange: vm.dateRange,
                  firstDate: vm.dateRangeDefault.start,
                  lastDate: vm.dateRangeDefault.end,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  final ButtonStyle buttonStyle = OutlinedButton.styleFrom(
    fixedSize: Size(90, 30),
    padding: .all(0),
  );
}
