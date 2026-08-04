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
import 'search_sheet/history_search_sheet.dart';
import 'card/history_card_base.dart';
import 'card/history_price_card.dart';
import 'card/history_rating_card.dart';
import 'package:ramyeon_counter/widget/custom_app_bar.dart';
import 'package:ramyeon_counter/widget/image_background.dart';
import 'package:ramyeon_counter/widget/loading_progress_indicator.dart';
// Other
import 'package:ramyeon_counter/utility/extension_methods/em_theme_data.dart';
// Partial
part 'actions/search_mode_action.dart';

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

  @override
  Widget build(BuildContext context) {
    return
    /* Color change */
    Theme(
      data: Theme.of(context).colorOverride(packageColor),
      child: Scaffold(
        /* Appbar */
        appBar: DefaultAppBar(
          context,
          '$heading履歴',
          actions: [SearchModeAction(vm, packageColor)],
        ),
        body: ImageBackground(
          vm: .cork(),
          child: FutureBuilder(
            future: vm.loadSource(),
            builder: (context, snapshot) => switch (snapshot.connectionState) {
              .done => switch (vm.isSourceEmpty) {
                true => _emptyCard(context),
                false => ListenableBuilder(
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
                ),
              },
              _ => LoadingProgressIndicator(
                context,
                vm: .new(
                  context,
                  overrideColor: packageColor,
                  duration: .new(milliseconds: 100),
                ),
              ),
            },
          ),
        ),
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
