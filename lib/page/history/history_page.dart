// Model
import 'package:ramyeon_counter/model/rating.dart';
import 'package:ramyeon_counter/model/stock.dart';
// Package
import 'package:flutter/material.dart';
// ViewModel
import 'view_model/history_page_vm_base.dart';
import 'view_model/history_price_page_vm.dart';
import 'view_model/history_rating_page_vm.dart';
// Widget
import 'history_search_sheet.dart';
import 'card/history_card_base.dart';
import 'card/history_price_card.dart';
import 'card/history_rating_card.dart';
import 'package:ramyeon_counter/widget/custom_app_bar.dart';
import 'package:ramyeon_counter/widget/loading_progress_indicator.dart';
// Other
import 'package:ramyeon_counter/utility/extension_methods/em_theme_data.dart';

class HistoryPricePage extends HistoryPageBase {
  HistoryPricePage({super.key, super.brandId, super.packageColor})
    : super(HistoryPricePageViewModel(brandId), '購入');
}

class HistoryRatingPage extends HistoryPageBase {
  HistoryRatingPage({super.key, super.brandId, super.packageColor})
    : super(HistoryRatingPageViewModel(brandId), '評価');
}

abstract class HistoryPageBase extends StatelessWidget {
  const HistoryPageBase(
    this.vm,
    this.heading, {
    super.key,
    this.brandId,
    this.packageColor,
  });

  final int? brandId;
  final Color? packageColor;
  final HistoryPageViewModelBase vm;

  /// 標目
  final String heading;

  static const _cardPadding = 5.0;
  static const _searchSheetSize = BoxConstraints(maxHeight: 270, maxWidth: 540);

  @override
  Widget build(BuildContext context) {
    return
    /* Color change */
    Theme(
      data: Theme.of(context).override(packageColor),
      child: Scaffold(
        /* Appbar */
        appBar: DefaultAppBar(
          context,
          '$heading履歴',
          actions: [
            ListenableBuilder(
              listenable: vm,
              builder: (_, c) =>
                  Visibility(visible: vm.searchButtonVisible, child: c!),
              child: IconButton(
                icon: const Icon(Icons.search_rounded),
                tooltip: '検索',
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    // 背景色（検索画面）
                    backgroundColor: switch (packageColor) {
                      Color c => ColorScheme.fromSeed(seedColor: c),
                      null => ColorScheme.of(context),
                    }.surfaceContainerHighest,
                    builder: (BuildContext context) => Container(
                      constraints: _searchSheetSize,
                      child: Center(
                        child: HistorySearchSheetBase.getInstance(
                          vm,
                          packageColor,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
        body: ListenableBuilder(
          listenable: vm,
          builder: (context, _) {
            // Loading
            if (vm.isSourceNull) {
              return switch (packageColor) {
                Color c => LoadingProgressIndicator.override(c),
                null => LoadingProgressIndicator.normal(context),
              };
            }
            // Empty
            else if (vm.isSourceEmpty) {
              return _emptyCard(context);
            }
            /* ListView */
            else {
              return ListenableBuilder(
                listenable: vm,
                builder: (context, _) => ListView.builder(
                  padding: .symmetric(vertical: _cardPadding / 2),
                  itemCount: vm.listviewCount,
                  itemBuilder: (context, int index) => Padding(
                    padding: .symmetric(
                      vertical: _cardPadding / 2,
                      horizontal: _cardPadding,
                    ),
                    child: _historyCard(context, index),
                  ),
                ),
              );
            }
          },
        ),
        backgroundColor: Color(0xFFBF9767), // Corkboard-color
      ),
    );
  }

  HistoryCardBase _historyCard(BuildContext context, int index) {
    final oneBased = index + 1;
    return switch (vm) {
      HistoryPricePageViewModel vm => switch (vm.view) {
        List<Stock> stocks when brandId == null => HistoryPriceCard.showBrand(
          context,
          stocks[index],
          oneBased,
          packageColor,
        ),
        List<Stock> stocks when brandId != null => HistoryPriceCard.noBrand(
          context,
          stocks[index],
          oneBased,
          packageColor,
        ),
        _ => throw UnimplementedError(),
      },
      HistoryRatingPageViewModel vm => switch (vm.view) {
        List<Rating> ratings when brandId == null =>
          HistoryRatingCard.showBrand(context, ratings[index], packageColor),
        List<Rating> ratings when brandId != null => HistoryRatingCard.noBrand(
          context,
          ratings[index],
          packageColor,
        ),
        _ => throw UnimplementedError(),
      },
      _ => throw UnimplementedError(),
    };
  }

  Container _emptyCard(BuildContext context) {
    final EdgeInsets padding = .symmetric(
      vertical: _cardPadding / 2,
      horizontal: _cardPadding,
    );
    return Container(
      alignment: .topCenter,
      child: Padding(
        padding: padding,
        child: Card(
          child: Padding(
            padding: padding,
            child: Text(
              'まだ$headingされていません',
              style: Theme.of(
                context,
              ).textTheme.titleLarge!.copyWith(fontFamily: 'ZenMaruGothic'),
            ),
          ),
        ),
      ),
    );
  }
}
