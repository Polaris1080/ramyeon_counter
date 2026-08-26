// Extention
import 'package:ramyeon_counter/utility/extension_methods/em_theme_data.dart';
// Package
import 'package:darq/darq.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// ViewModel
import '../view_model/history_page_vm_base.dart';
import '../view_model/history_price_page_vm.dart';
import '../view_model/history_rating_page_vm.dart';

// Widget
import 'package:ramyeon_counter/widget/rating/rating_range_selecter.dart';

// Partial

class HistorySearchSheet<T extends HistoryPageViewModelBase>
    extends StatelessWidget {
  /* Setting */
  static const _buttonSpacing = 10.0, _rowSpacing = 10.0;

  const HistorySearchSheet(this.vm, this.packageColor, {super.key});

  /* Argument */
  final T vm;
  final Color? packageColor;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).colorOverride(packageColor), // Color change
      child: Column(
        spacing: _rowSpacing,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: [
          /* 1st Row */
          Column(
            children: [
              headline(context, text: '期間'),
              ListenableBuilder(
                listenable: vm,
                builder: (context, _) {
                  final df = DateFormat('y/MM/dd');
                  return Text(
                    '${df.format(vm.dateRange.start)} ~ ${df.format(vm.dateRange.end)}',
                    style: Theme.of(context).textTheme.titleLarge!
                        .copyWith(fontFamily: 'ZenMaruGothic'),
                    maxLines: 1,
                    overflow: .ellipsis,
                  );
                },
              ),
            ],
          ),
          /* 2nd Row */
          //secondRow(context),
          switch (vm) {
            HistoryPricePageViewModel() => secondRow1(context),
            HistoryRatingPageViewModel() => secondRow2(context),
            HistoryPageViewModelBase _ => throw UnimplementedError(),
          },
          /* 3rd Row */
          Wrap(
            spacing: _buttonSpacing, // Horizontal Spacing
            runSpacing: _rowSpacing, // Vertical Spacing
            alignment: .center,
            children: thirdRow(context).select((s, _) {
              final (:text, :onPressed) = s;
              final cs = ColorScheme.of(context);
              /* Button */
              return OutlinedButton(
                style: OutlinedButton.styleFrom(
                  backgroundColor: cs.primaryFixed,
                  fixedSize: Size(90, 30),
                  padding: .all(0),
                ),
                onPressed: onPressed,
                child: Text(
                  text,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: cs.onPrimaryFixed,
                    fontFamily: 'ZenKakuGothicNew',
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  /// 見出し
  Text headline(BuildContext context, {required String text}) {
    final cs = ColorScheme.of(context);
    return .new(
      text,
      style: Theme.of(context).textTheme.headlineMedium!.copyWith(
        color: cs.onPrimaryFixed,
        decoration: TextDecoration.underline,
        decorationColor: cs.onPrimaryFixedVariant,
        fontFamily: 'ZenKakuGothicNew',
      ),
    );
  }

  Column secondRow1(BuildContext context) {
    final viewModel = (vm as HistoryPricePageViewModel).priceRange;
    return Column(
      children: [
        headline(context, text: '価格'),
        ListenableBuilder(
          listenable: viewModel,
          /* PriceRangeSelecter */
          // Failed to update ui::AXTree
          builder: (context, _) => ExcludeSemantics(
            child: RangeSlider(
              divisions: viewModel.divisions,
              labels: viewModel.labels,
              max: viewModel.maxRange,
              values: viewModel.priceRange,
              onChanged: viewModel.priceRangeChanged,
            ),
          ),
        ),
      ],
    );
  }

  Column secondRow2(BuildContext context) {
    final viewModel = (vm as HistoryRatingPageViewModel).ratingRange;
    return Column(
      children: [
        headline(context, text: '評価'),
        RatingRangeSelecter(viewModel),
      ],
    );
  }

  List<({String text, VoidCallback onPressed})> thirdRow(
    BuildContext context,
  ) => [
    (
      text: 'リセット',
      onPressed: () {
        vm.reset();
        Navigator.pop(context);
      },
    ),
    (
      text: '検索',
      onPressed: () {
        vm.search();
        Navigator.pop(context);
      },
    ),
    (
      text: '期間設定',
      onPressed: () async => vm.dateRange = await showDateRangePicker(
        context: context,
        initialDateRange: vm.dateRange,
        firstDate: vm.dateRangeDefault.start,
        lastDate: vm.dateRangeDefault.end,
      ),
    ),
  ];
}
