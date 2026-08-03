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
          spacing: StatisticsPage.rankingPageVerticalPadding,
          children: [
            /* 選択 */
            FutureBuilder(
              future: RatingRepository().getLastYear(),
              builder: (context, snapshot) =>
                  AllOrYearSelector(selected, oldestYear: snapshot.data),
              initialData: null,
            ),
            /* テーブル */
            ValueListenableBuilder(
              valueListenable: selected,
              builder: (context, year, _) => switch (year) {
                // year selected
                int year => FutureBuilder(
                  future: StatisticsDataContext().readRankingRatingData(
                    year: year,
                  ),
                  builder: (context, snapshot) => switch (snapshot.data) {
                    Map<String, double> data => rankingTable(data, year: year),
                    _ => LoadingProgressIndicator(
                      context,
                      duration: .new(milliseconds: 100),
                    ),
                  },
                ),
                // year not selected
                _ => rankingTable(data),
              },
            ),
          ],
        ),
      ),
    );
  }

  RankingTable rankingTable(Map<String, double> data, {int? year}) =>
      RankingTable(
        [
          ...data.entries.select(
            (s, i) => (rank: i + 1, name: s.key, value: s.value),
          ),
        ],
        heading: _heading,
        title: "$_tableTitle${year != null ? '（$year）' : ''}",
        width: StatisticsPage.rankingPageTableWidth,
      );
}
