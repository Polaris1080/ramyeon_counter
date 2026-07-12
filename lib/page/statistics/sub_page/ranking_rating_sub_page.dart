part of '../statistics_page.dart';

class RankingRatingSubPage extends StatelessWidget {
  static const _tableTitle = "ランキング：評価";

  const RankingRatingSubPage(this.data, {super.key});

  final Map<String, double> data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: StatisticsPage.rankingPageHorizontalPadding,
        horizontal: StatisticsPage.rankingPageVerticalPadding,
      ),
      child: Center(
        heightFactor: 1,
        child: Column(
          children: [
            // TODO:年別[余裕があれば]
            RankingTable(
              [
                ...data.entries.select(
                  (s, i) => RankingTableData(
                    rank: i + 1,
                    name: s.key,
                    value: s.value,
                  ),
                ),
              ],
              heading: ['順位', '品名', '評価'],
              title: _tableTitle,
              width: StatisticsPage.rankingPageTableWidth,
            ),
          ],
        ),
      ),
    );
  }
}
