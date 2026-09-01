// Package
import 'package:darq/darq.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ramyeon_counter/models/model/ramyeon/repository/ramyeon_repository.dart';
import 'package:ramyeon_counter/models/model/ramyeon/repository/rating_repository.dart';
import 'package:ramyeon_counter/models/model/ramyeon/repository/stock_repository.dart';
// Widget
import 'package:ramyeon_counter/widget/rating/rating_viewer.dart';

class const RamyeonDataViewer({super.key, required final int ramyeonId})
    extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final dt = DateFormat('yyyy年MM月dd日');
    return Column(
      mainAxisSize: .min,
      spacing: 8,
      children: [
        // TODO:仮実装
        FutureBuilder(
          future: RamyeonRepository().read(ramyeonId),
          builder: (context, asyncSnapshot) {
            return switch (asyncSnapshot.connectionState) {
              .done => Text(asyncSnapshot.requireData.brand),
              _ => Text("ramyeon.brand"),
            };
          },
        ),
        FutureBuilder(
          future: RatingRepository().readByBrandId(ramyeonId),
          builder: (context, asyncSnapshot) {
            return switch (asyncSnapshot.connectionState) {
              .done => RatingViewer(
                vm: .new(asyncSnapshot.requireData.average((x) => x.rating)),
              ),
              _ => SizedBox(),
            };
          },
        ),
        FutureBuilder(
          future: StockRepository().readByBrandId(ramyeonId),
          builder: (context, asyncSnapshot) {
            return switch (asyncSnapshot.connectionState) {
              .done => Text(
                '価格${asyncSnapshot.requireData.where((x) => x.purchaseDate.isAfter(DateTime.now().subtract(Duration(days: 365)))).average((x) => x.price)}円',
              ),
              _ => SizedBox(),
            };
          },
        ),
        Text(
          '${dt.format(DateTime.now().subtract(Duration(days: 365)))}-${dt.format(DateTime.now())}',
        ),
      ],
    );
  }
}
