part of 'history_search_sheet.dart';

class PriceSearchSheet extends HistorySearchSheetBase {
  const PriceSearchSheet(
    HistoryPricePageViewModel super.vm,
    super.packageColor, {
    super.key,
  });

  @override
  Column secondRow(BuildContext context) {
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
}
