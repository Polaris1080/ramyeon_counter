part of '../statistics_page.dart';

class _StockBarChart extends StatelessWidget {
  const _StockBarChart();

  @override
  Widget build(BuildContext context) {
    //
    return FutureBuilder(
      future: StockChartDataContext().readByBrand(),
      builder: (context, asyncSnapshot) {
        return BarChart(
          BarChartData(
            barGroups: [
              // x:brand (rameonから取ればよい) y:price(stock)
              BarChartGroupData(x: 1, barRods: [BarChartRodData(toY: 50)]),
              BarChartGroupData(x: 5),
            ],
          ),
        );
      },
    );
  }
}
