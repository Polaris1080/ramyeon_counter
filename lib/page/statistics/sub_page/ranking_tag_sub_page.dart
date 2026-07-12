part of '../statistics_page.dart';

class RankingTagSubPage extends StatelessWidget {
  static const _tableTitle = "ランキング：タグ";

  const RankingTagSubPage(this.vm, this.data, {super.key});

  final StatisticsPageViewModel vm;
  final List<TagData> data;

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
            // TODO:もっと見る[余裕があれば]
            RankingTable(
              [
                ...data.select(
                  (s, _) => RankingTableData(
                    rank: s.rank,
                    name: s.tag,
                    value: s.count,
                  ),
                ),
              ],
              heading: ['順位', '品名', '個数'],
              title: _tableTitle,
              width: StatisticsPage.rankingPageTableWidth,
            ),
            // TODO:全部見る
          ],
        ),
      ),
    );
  }
}
