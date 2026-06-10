import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class StockBarChart extends StatelessWidget {
  const StockBarChart({super.key});

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        barGroups: [
          BarChartGroupData(x: 1, barRods: [BarChartRodData(toY: 50)]),
          BarChartGroupData(x: 2),
        ],
      ),
    );
  }
}
