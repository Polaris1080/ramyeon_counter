part of '../statistics_page.dart';

class EatPieChart extends StatelessWidget {
  const EatPieChart(this.data, {super.key});

  final List<RamyeonListData> data;

  @override
  Widget build(BuildContext context) {
    final allCount = data.select((s, _) => s.count).sum();
    List<PieChartSectionData> section() {
      var source = data
          .where((w) => (w.count / allCount) >= 0.1)
          .select(
            (x, _) => PieChartSectionData(
              value: x.count.toDouble(),
              title: x.brand,
              radius: (x.count / allCount) > 0.25 ? 50 : 45,
              color: switch (x.packageColor) {
                int packageColor => Color(packageColor),
                _ => Colors.lightGreen[300],
              },
            ),
          )
          .toList();
      final otherSource = data
          .where((w) => (w.count / allCount) < 0.1)
          .toList();
      if (otherSource.select((s, _) => s.count).sum().toDouble() > 0) {
        source.add(
          PieChartSectionData(
            value: otherSource.select((s, _) => s.count).sum().toDouble(),
            title: "その他",
            color: Colors.grey,
            radius: 40,
          ),
        );
      }
      return source;
    }

    return Center(
      child: SizedBox(
        width: 300,
        height: 300,
        child: Stack(
          children: [
            PieChart(
              PieChartData(
                centerSpaceRadius: double.infinity,
                centerSpaceColor: Colors.grey.withAlpha(128),
                sections: section(),
                startDegreeOffset: 0,
              ),
            ),
            Center(child: Text("総数：$allCount")),
          ],
        ),
      ),
    );
  }
}
