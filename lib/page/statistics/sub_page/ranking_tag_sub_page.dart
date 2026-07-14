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
                  (s, _) => RankingTableData(
                    rank: s.rank,
                    name: s.tag,
                    value: s.count,
                  ),
                ),
              ],
              heading: _tableHeading,
              title: _tableTitle,
              width: StatisticsPage.rankingPageTableWidth,
            ),
            /* ShowAllTag */
            ValueListenableBuilder(
              valueListenable: seeAll,
              builder: (context, flag, _) => OutlinedButton.icon(
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.transparent, // hover Color
                  backgroundColor: flag
                      ? cs.tertiaryFixedDim
                      : cs.tertiaryFixed,
                  iconColor: cs.tertiaryContainer,
                  side: BorderSide(color: cs.tertiary, width: 2.0),
                  iconSize: 36,
                ),
                icon: Icon(
                  flag
                      ? Icons.arrow_drop_down_rounded
                      : Icons.arrow_right_rounded,
                ),
                label: Text(
                  "すべて表示",
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: cs.onTertiaryFixed,
                    fontFamily: "ZenMaruGothic",
                  ),
                ),
                onPressed: () => seeAll.flip(),
              ),
            ),
            /* AllTag */
            ValueListenableBuilder(
              valueListenable: seeAll,
              builder: (context, flag, child) =>
                  Visibility.maintain(visible: flag, child: child!),
              child: FutureBuilder(
                future: vm.allTagData,
                builder: (context, snapshot) => switch (snapshot.data) {
                  List<TagData> data => Wrap(
                    children: [
                      ...data.select((s, _) => Chip(label: Text(s.tag))),
                    ],
                  ),
                  _ => const SizedBox(),
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
