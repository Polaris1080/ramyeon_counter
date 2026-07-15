part of '../statistics_page.dart';

class RankingTagSubPage extends StatelessWidget {
  static const _columuSpacing = 12.5,
      _tableTitle = "ランキング：タグ",
      _tableHeading = ['順位', '品名', '個数'];

  RankingTagSubPage(this.vm, this.data, {super.key});

  final StatisticsPageViewModel vm;
  final List<TagData> data;

  /// すべて（のタグを）表示
  final ValueNotifier<bool> seeAll = .new(false);

  @override
  Widget build(BuildContext context) {
    final cs = ColorScheme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: StatisticsPage.rankingPageVerticalPadding,
        horizontal: StatisticsPage.rankingPageHorizontalPadding,
      ),
      child: Center(
        heightFactor: 1,
        child: Column(
          spacing: _columuSpacing,
          children: [
            /* Ranking */
            RankingTable(
              [
                ...data.select(
                  (s, _) => (rank: s.rank, name: s.tag, value: s.count),
                ),
              ],
              heading: _tableHeading,
              title: _tableTitle,
              width: StatisticsPage.rankingPageTableWidth,
            ),
            AllTagViewArea(vm),
          ],
        ),
      ),
    );
  }
}
