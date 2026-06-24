// Package
import 'package:darq/darq.dart';
import 'package:ramyeon_counter/ramyeon_database.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
// Model
import 'package:ramyeon_counter/model/base/context_base.dart';

class StatisticsDataContext extends RamyeonContextBase {
  Future<Map<String, double>> readRankingRatingData({int? year}) async {
    const RamyeonDatabaseTable mainTable = .rating, subTable = .ramyeon;
    const String keyRow = 'brand', valueRow = 'rate';
    return (await (await db).rawQuery('''
        select $keyRow, avg(rating) as $valueRow from ${mainTable.name}
        INNER JOIN ${subTable.name} ON ${mainTable.name}.brandId = ${subTable.name}.id
        ${year != null && year >= 0 ? "WHERE date BETWEEN '$year-01-01' AND '$year-12-31'" : ''}
        group by brandId ORDER BY rate DESC
      ''')).toMap((r) => MapEntry(r[keyRow] as String, r[valueRow] as double));
  }
}

class TestTagDataContext extends StatisticsDataContext {
  @override
  Future<Database> get db => TestRamyeonDatabase().open();
}
