part of '../statistics_page.dart';

class RankingTagSubPage extends StatelessWidget {
  /* Setting */
  static const _tableTitle = "ランキング：タグ", _tableHeading = ['順位', '品名', '個数'];

  const RankingTagSubPage(this.vm, this.data, {super.key});

  /* Value */
  final StatisticsPageViewModel vm;
  final List<TagData> data;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: StatisticsPage.rankingPageVerticalPadding,
          horizontal: StatisticsPage.rankingPageHorizontalPadding,
        ),
        child: Center(
          heightFactor: 1,
          child: Column(
            crossAxisAlignment: .center,
            spacing: StatisticsPage.rankingPageVerticalPadding,
            children: [
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
      ),
    );
  }
}
