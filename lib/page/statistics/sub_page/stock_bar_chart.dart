part of '../statistics_page.dart';

class _StockBarChart extends StatelessWidget {
  _StockBarChart();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: StatisticsDataContext().readStockChartData(),
      builder: (context, asyncSnapshot) {
        if (asyncSnapshot.hasData) {
          return BarChart(
            BarChartData(
              barGroups: asyncSnapshot.data!.entries
                  .select(
                    (e, _) => BarChartGroupData(
                      x: e.key,
                      barRods: [BarChartRodData(toY: e.value)],
                    ),
                  )
                  .toList(),
              titlesData: .new(
                leftTitles: .new(),
                topTitles: .new(),
                bottomTitles: .new(),
              ),
              barTouchData: .new(
                touchTooltipData: .new(
                  getTooltipItem: (group, groupIndex, rod, rodIndex) =>
                      .new(groups[groupIndex], .new()),
                ),
              ),
            ),
          );
        } else {
          return nil;
        }
      },
    );
  }

  final List<String> groups = ['群馬', '愛知', '千葉', '茨城', '茨', '城'];
}
