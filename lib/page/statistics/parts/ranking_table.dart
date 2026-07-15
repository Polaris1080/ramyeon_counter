// Package
import 'dart:math';
import 'package:darq/darq.dart';
import 'package:flutter/material.dart';
// Extention
import 'package:ramyeon_counter/utility/extension_methods/em_int.dart';

class RankingTable extends StatelessWidget {
  /* Setting */
  static const _contentPadding = 2.5;

  RankingTable(
    this.data, {
    super.key,
    required List<String> heading,
    this.title = "",
    required this.width,
  }) : heading = [
         heading.elementAtOrDefault(0, defaultValue: '順位'),
         heading.elementAtOrDefault(1, defaultValue: '品名'),
         heading.elementAtOrDefault(2, defaultValue: ''),
       ];

  /// 内容
  final List<({int rank, String name, num value})> data;

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
          /* Title */
          Text(
            title,
            style: Theme.of(
              context,
            ).textTheme.headlineSmall!.copyWith(fontFamily: "ZenMaruGothicNew"),
          ),
          /* Table */
          Table(
            columnWidths: <int, TableColumnWidth>{
              0: MinColumnWidth(
                FixedColumnWidth(max((data.length.digit + 1) * 10, 50)),
                FractionColumnWidth(0.3),
              ),
              1: FlexColumnWidth(),
              2: FixedColumnWidth(50),
            },
            defaultVerticalAlignment: .middle,
            children: [
              /* Header */
              TableRow(
                children: [
                  ...heading.select(
                    (data, i) => TableCell(
                      child: Text(
                        data,
                        textAlign: .center,
                        style: Theme.of(context).textTheme.titleMedium!
                            .copyWith(
                              color: HSVColor.fromAHSV(
                                1.0,
                                i * 120,
                                1.0,
                                0.5,
                              ).toColor(),
                            ),
                      ),
                    ),
                  ),
                ],
              ),
              /* Content */
              ...data.select(
                (s, _) => TableRow(
                  children: [
                    TableCell(
                      child: Padding(
                        padding: const EdgeInsets.all(_contentPadding),
                        child: Text(
                          "${s.rank}位",
                          textAlign: .end,
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                      ),
                    ),
                    TableCell(
                      child: Padding(
                        padding: const EdgeInsets.all(_contentPadding),
                        child: Text(
                          s.name,
                          textAlign: .center,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                    ),
                    TableCell(
                      child: Padding(
                        padding: const EdgeInsets.all(_contentPadding),
                        child: Text(
                          s.value.toString(),
                          textAlign: .end,
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
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
}
