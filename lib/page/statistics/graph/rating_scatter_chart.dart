import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class RatingScatterChart extends StatelessWidget {
  const RatingScatterChart({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ScatterChart(
      ScatterChartData(
        scatterSpots: [
          .new(110, 8),
          .new(150, 5),
          .new(199, 10),
          .new(110, 9),
        ],
      ),
    );
  }
}
