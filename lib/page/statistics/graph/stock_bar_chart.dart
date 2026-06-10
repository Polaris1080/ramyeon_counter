import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:ramyeon_counter/model/context/stock_chart_data_context.dart';

class StockBarChart extends StatelessWidget {
  const StockBarChart({super.key});

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
