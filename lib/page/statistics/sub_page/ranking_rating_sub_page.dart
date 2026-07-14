part of '../statistics_page.dart';

class RankingRatingSubPage extends StatelessWidget {
  static const _tableTitle = "ランキング：評価";
  static const _heading = ['順位', '品名', '評価'];

  RankingRatingSubPage(this.data, {super.key});

  final Map<String, double> data;
  final ValueNotifier<int?> selected = .new(null);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: StatisticsPage.rankingPageVerticalPadding,
        horizontal: StatisticsPage.rankingPageHorizontalPadding,
      ),
      child: Center(
        heightFactor: 1,
        child: Column(
          crossAxisAlignment: .center,
          children: [
            /* 選択 */
            AllOrYearSelector(selected, oldestYear: null),
            /* テーブル */
            ValueListenableBuilder(
              valueListenable: selected,
              builder: (context, year, _) => year is int
                  // year selected
                  ? FutureBuilder(
                      future: StatisticsDataContext().readRankingRatingData(
                        year: year,
                      ),
                      builder: (context, snapshot) => switch (snapshot.data) {
                        Map<String, double> data => RankingTable(
                          [
                            ...data.entries.select(
                              (s, i) => RankingTableData(
                                rank: i + 1,
                                name: s.key,
                                value: s.value,
                              ),
                            ),
                          ],
                          heading: _heading,
                          title: "$_tableTitle（$year）",
                          width: StatisticsPage.rankingPageTableWidth,
                        ),
                        _ => DelayedLoadingProgressIndicator.normal(context),
                      },
                    )
                  // year not selected
                  : RankingTable(
                      [
                        ...data.entries.select(
                          (s, i) => RankingTableData(
                            rank: i + 1,
                            name: s.key,
                            value: s.value,
                          ),
                        ),
                      ],
                      heading: _heading,
                      title: _tableTitle,
                      width: StatisticsPage.rankingPageTableWidth,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
