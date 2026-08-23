// Base
import '../../base/context_base.dart';
import '../../database/ramyeon/ramyeon_database_tables.dart';

// Package
import 'package:darq/darq.dart';
import 'package:ramyeon_counter/ramyeon_database.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class StatisticsDataContext extends RamyeonContextBase {
  Future<Map<int, double>> readStockChartData({int? year}) async {
    const RamyeonDatabaseTables mainTable = .stock, subTable = .ramyeon;
    const String keyRow = 'brandId', valueRow = 'amount';
    return (await (await db).rawQuery(
      '''
        select $keyRow, sum(price) as $valueRow from ${mainTable.name}
        INNER JOIN ${subTable.name} ON ${mainTable.name}.brandId = ${subTable.name}.id
        ${year != null && year >= 0 ? "WHERE date BETWEEN '$year-01-01' AND '$year-12-31'" : ''}
        group by $keyRow ORDER BY $valueRow
      ''',
    )).toMap(
      (t) => MapEntry(t[keyRow] as int, (t[valueRow] as int).toDouble()),
    );
  }

  Future<Map<String, double>> readRankingRatingData({int? year}) async {
    const RamyeonDatabaseTables mainTable = .rating, subTable = .ramyeon;
    const String keyRow = 'brand', valueRow = 'rate';
    return (await (await db).rawQuery('''
        select $keyRow, avg(rating) as $valueRow from ${mainTable.name}
        INNER JOIN ${subTable.name} ON ${mainTable.name}.brandId = ${subTable.name}.id
        ${year != null && year >= 0 ? "WHERE date BETWEEN '$year-01-01' AND '$year-12-31'" : ''}
        group by brandId ORDER BY $valueRow DESC
      ''')).toMap((t) => MapEntry(t[keyRow] as String, t[valueRow] as double));
  }
}

class TestTagDataContext extends StatisticsDataContext {
  @override
  Future<Database> get db => TestRamyeonDatabase().open();
}
