part of 'history_search_sheet.dart';

class RatingSearchSheet extends HistorySearchSheetBase {
  const RatingSearchSheet(
    HistoryRatingPageViewModel super.vm,
    super.packageColor, {
    super.key,
  });

  @override
  Column secondRow(BuildContext context) {
    final viewModel = (vm as HistoryRatingPageViewModel).ratingRange;
    return Column(
      children: [
        headline(context, text: '評価'),
        RatingRangeSelecter(viewModel),
      ],
    );
  }
}
