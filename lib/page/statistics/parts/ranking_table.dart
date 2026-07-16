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
    final tt = Theme.of(context).textTheme;

    return SizedBox(
      width: width,
      child: Column(
        children: [
          /* Title */
          Text(
            title,
            style: tt.headlineSmall!.copyWith(fontFamily: "ZenMaruGothicNew"),
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
                        style: tt.titleMedium!.copyWith(
                          color: splitHue(i, split: heading.length, value: 0.5),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              /* Content */
              ...data.select((s, i) {
                final (:rank, :name, :value) = s;
                final split = data.length;
                return TableRow(
                  children: [
                    ...<({String text, TextAlign align, TextStyle style})>[
                      (text: "$rank位", align: .end, style: tt.labelLarge!),
                      (text: name, align: .center, style: tt.bodyLarge!),
                      (text: "$value", align: .end, style: tt.labelLarge!),
                    ].select((s, _) {
                      final (:text, :align, :style) = s;
                      return TableCell(
                        child: Padding(
                          padding: const EdgeInsets.all(_contentPadding),
                          child: Text(
                            text,
                            textAlign: align,
                            style: style.copyWith(
                              color: splitHue(i, split: split, value: 0.75),
                            ),
                          ),
                        ),
                      );
                    }),
                  ],
                );
              }),
            ],
          ),
        ],
      ),
    );
  }

  Color splitHue(
    int i, {
    required int split,
    double saturation = 1.0,
    double value = 1.0,
  }) {
    assert(split > 0, "Out of range : split");
    assert(0 <= saturation && saturation <= 1.0, "Out of range : saturation");
    assert(0 <= value && value <= 1.0, "Out of range : value");
    const hue = 360;
    return HSVColor.fromAHSV(
      1.0,
      i * (hue / split) % hue,
      saturation,
      value,
    ).toColor();
  }
}
