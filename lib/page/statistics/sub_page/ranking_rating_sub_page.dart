part of '../statistics_page.dart';

class RankingRatingSubPage extends StatelessWidget {
  const RankingRatingSubPage(this.data, {super.key});

  final Map<String, double> data;

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
          children: data.entries
              .select(
                (s, i) => TableRow(
                  children: <Widget>[
                    TableCell(
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: Text("${i + 1}位", textAlign: .end),
                      ),
                    ),
                    TableCell(
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: Text(s.key, textAlign: .end),
                      ),
                    ),
                    TableCell(
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: Text(s.value.toString(), textAlign: .end),
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
