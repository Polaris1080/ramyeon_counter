part of '../statistics_page.dart';

class RankingRatingSubPage extends StatelessWidget {
  static const _tableTitle = "ランキング：評価";

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
            AllOrYearSelector(selected),
            // TODO:年別[余裕があれば]
            /* テーブル */
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

class AllOrYearSelector extends StatelessWidget {
  AllOrYearSelector(this.selected, {super.key});

  final ValueNotifier<int?> selected;
  final ValueNotifier<bool> onlyYear = .new(false);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.blue, // 枠線の色
          width: 2.0, // 枠線の太さ
        ),
      ),
      child: Row(
        mainAxisSize: .min,
        children: [
          /* Label */
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.5),
            child: const Text("年別"),
          ),
          ValueListenableBuilder(
            valueListenable: onlyYear,
            builder: (context, flag, _) => Switch(
              value: flag,
              activeThumbColor: Colors.red,
              onChanged: (value) => onlyYear.value = value,
            ),
          ),
          TextButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: Text("Select Year"),
                  content: SizedBox(
                    width: 300,
                    height: 300,
                    child: YearPicker(
                      firstDate: DateTime(DateTime.now().year - 100, 1),
                      lastDate: DateTime(DateTime.now().year + 100, 1),
                      selectedDate: null,
                      onChanged: (DateTime dateTime) {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ),
              );
            },
            child: const Text('選択'),
          ),
        ],
      ),
    );
  }
}
