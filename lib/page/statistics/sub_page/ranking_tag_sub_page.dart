part of '../statistics_page.dart';

class RankingTagSubPage extends StatelessWidget {
  const RankingTagSubPage(this.data, this.vm, {super.key});

  final List<TagData> data;
  final StatisticsPageViewModel vm;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        constraints: BoxConstraints(maxWidth: 300),
        child: Table(
          border: TableBorder.all(),
          columnWidths: <int, TableColumnWidth>{
            // 順位
            0: MinColumnWidth(
              FixedColumnWidth(max((data.length.digit + 1) * 10, 40)),
              FractionColumnWidth(0.3),
            ),
            // 品名
            1: FlexColumnWidth(),
            // 評価
            2: FixedColumnWidth(40),
          },
          defaultVerticalAlignment: .middle,
          children: data
              .select(
                (s, i) => TableRow(
                  children: <Widget>[
                    TableCell(
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: Text(s.rank.toString(), textAlign: .end),
                      ),
                    ),
                    TableCell(
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: Text(s.tag, textAlign: .end),
                      ),
                    ),
                    TableCell(
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: Text(s.count.toString(), textAlign: .end),
                      ),
                    ),
                  ],
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
