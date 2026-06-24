// Package
import 'package:darq/darq.dart';
import 'package:ramyeon_counter/ramyeon_database.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
// Model
import 'package:ramyeon_counter/model/base/context_base.dart';

class RankingRatingContext extends RamyeonContextBase {
  @override
  RamyeonDatabaseTable get table => .rating;
  RamyeonDatabaseTable get subTable => .ramyeon;

  Future<Map<String, double>> read({int? year}) async =>
      (await (await db).rawQuery(
        '''
        select brand, avg(rating) as rate from ${table.name}
        INNER JOIN ${subTable.name} ON ${table.name}.brandId = ${subTable.name}.id
        ${year != null && year >= 0 ? "WHERE date BETWEEN '$year-01-01' AND '$year-12-31'" : ''}
        group by brandId ORDER BY rate DESC
      ''',
      )).toMap(
        (r) => MapEntry(
          r['brand'] as String, // Key
          r['rate'] as double, // Value
        ),
      );
}

class TestTagDataContext extends RankingRatingContext {
  @override
  Future<Database> get db => TestRamyeonDatabase().open();
}
