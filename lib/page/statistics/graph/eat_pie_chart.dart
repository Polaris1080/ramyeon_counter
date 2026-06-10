import 'package:darq/darq.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:ramyeon_counter/model/context/ramyeon_list_data_context.dart';

class EatPieChart extends StatelessWidget {
  const EatPieChart({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: RamyeonListDataContext().readByBrand(''),
      builder: (context, asyncSnapshot) {
        if (asyncSnapshot.hasData) {
          var t1 = asyncSnapshot.data!;
          var t2 = t1
              .select(
                (x, _) => PieChartSectionData(
                  value: x.count.toDouble(),
                  title: x.brand,
                ),
              )
              .toList();
          return PieChart(PieChartData(sections: t2));
        } else {
          return PieChart(
            PieChartData(
              sections: [
                .new(value: 60, title: 'a\n60'),
                // value（個数） color title（brandmane）
                // ramyeonから取る
                // color ramyeon
                // value rameon id -> stock.count
                // title brand
                .new(value: 10, title: 'b:10'),
              ],
            ),
          );
        }
      },
    );
  }
}
