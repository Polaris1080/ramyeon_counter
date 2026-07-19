part of '../history_page.dart';

class SearchModeAction extends StatelessWidget {
  const SearchModeAction(this.vm, this.packageColor, {super.key});

  /* Argument */
  final HistoryPageViewModelBase vm;
  final Color? packageColor;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: vm,
      builder: (_, c) => Visibility(visible: vm.isSearchModeEnable, child: c!),
      /* SearchButton */
      child: IconButton(
        icon: const Icon(Icons.search_rounded),
        tooltip: '検索',
        onPressed: () => showModalBottomSheet(
          context: context,
          builder: (BuildContext context) => Container(
            // SearchSheetSize
            constraints: .new(maxWidth: 540, maxHeight: 270),
            child: Center(
              child: switch (vm) {
                HistoryPricePageViewModel vm => PriceSearchSheet(
                  vm,
                  packageColor,
                ),
                HistoryRatingPageViewModel vm => RatingSearchSheet(
                  vm,
                  packageColor,
                ),
                HistoryPageViewModelBase _ => throw UnimplementedError(),
              },
            ),
          ),
        ),
      ),
    );
  }
}
