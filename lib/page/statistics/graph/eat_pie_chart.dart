import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class EatPieChart extends StatelessWidget {
  const EatPieChart({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return PieChart(
      PieChartData(
        sections: [
          .new(value: 60),
          .new(value: 10),
          .new(value: 10),
          .new(value: 10),
          .new(value: 10),
          .new(value: 10),
        ],
      ),
    );
  }
}
