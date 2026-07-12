// Package
import 'dart:math';
import 'package:darq/darq.dart';
import 'package:flutter/material.dart';
// Extention
import 'package:ramyeon_counter/utility/extension_methods/em_int.dart';

class RankingTable extends StatelessWidget {
  const RankingTable(
    this.data, {
    super.key,
    required this.heading,
    this.title = "",
    required this.width,
  });

  /// 内容
  final List<RankingTableData> data;

  /// 見出し
  final List<String> heading;

  /// 題名
  final String title;

  /// 長さ
  final double? width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Column(
        children: [
          /* 1st Row(Title) */
          Text(title),
          /* 2nd Row(Table) */
          Table(
            border: TableBorder.all(),
            columnWidths: <int, TableColumnWidth>{
              0: MinColumnWidth(
                FixedColumnWidth(max((data.length.digit + 1) * 10, 40)),
                FractionColumnWidth(0.3),
              ),
              1: FlexColumnWidth(),
              2: FixedColumnWidth(40),
            },
            defaultVerticalAlignment: .middle,
            children: [
              header(heading),
              ...data.select(
                (s, _) => TableRow(
                  children: <Widget>[
                    TableCell(
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: Text("${s.rank}位", textAlign: .end),
                      ),
                    ),
                    TableCell(
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: Text(s.name, textAlign: .center),
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
              ),
            ],
          ),
        ],
      ),
    );
  }

  TableRow header(List<String> header) => TableRow(
    children: [
      TableCell(
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Text(
            header.elementAtOrDefault(0, defaultValue: '順位'),
            textAlign: .center,
          ),
        ),
      ),
      TableCell(
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Text(
            header.elementAtOrDefault(1, defaultValue: '品名'),
            textAlign: .center,
          ),
        ),
      ),
      TableCell(
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Text(
            header.elementAtOrDefault(1, defaultValue: ''),
            textAlign: .center,
          ),
        ),
      ),
    ],
  );
}

class RankingTableData {
  /// 順位
  final int rank;

  /// 名称
  final String name;

  /// 値
  final num value;

  RankingTableData({
    required this.rank,
    required this.name,
    required this.value,
  });
}
