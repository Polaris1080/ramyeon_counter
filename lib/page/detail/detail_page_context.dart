// Extension
import 'package:ramyeon_counter/models/database/ramyeon/table/rating_table_columns.dart';
import 'package:ramyeon_counter/models/database/ramyeon/table/stock_table_columns.dart';

// Model
import 'package:ramyeon_counter/models/context/base/context_base.dart';
import 'package:ramyeon_counter/models/database/ramyeon/ramyeon_database_tables.dart';
import 'package:ramyeon_counter/models/database/ramyeon/table/ramyeon_table_columns.dart';
import 'package:ramyeon_counter/models/model/base/em_castable_query_map.dart';

class DetailPageContext extends RamyeonContextBase {
  Future<String> readBrand(int id) async {
    final table = RamyeonDatabaseTables.ramyeon.name,
        columu1 = RamyeonTableColumns.brand.name,
        result = ((await (await db).query(
          table,
          columns: [columu1],
          where: 'id = ?',
          whereArgs: [id],
        )).first);
    return columu1.cast<String>(result);
  }

  Future<(double? price, DateTime? date)> readPriceAverage(int brandId) async {
    const columu1 = 'average', columu2 = 'date', yearRange = 1;
    final table = RamyeonDatabaseTables.stock.name,
        columuA = StockTableColumns.price.name,
        columuB = StockTableColumns.purchaseDate.name,
        result = (await (await db).query(
          table,
          columns: ['avg($columuA) as $columu1', 'max($columuB) as $columu2'],
          where:
              '''
            brandId = ? AND $columuB >= datetime(
              (SELECT max($columuB) FROM $table WHERE brandId = ?),
              '-$yearRange year'
            )  
          ''',
          whereArgs: [brandId, brandId],
        )).first;
    return (columu1.cast<double?>(result), columu2.castDateTime(result));
  }

  Future<double> averageByBrandId(int brandId) async {
    const columu1 = 'average';
    final table = RamyeonDatabaseTables.rating.name,
        columuA = RatingTableColumns.rating.name,
        result = columu1.cast<double?>(
          (await (await db).query(
            table,
            columns: ['avg($columuA) as $columu1'],
            where: 'brandId = ?',
            whereArgs: [brandId],
          )).first,
        );
    return result ?? 0.0;
  }

  Future<Set<String>> readTag(int id) async {
    final table = RamyeonDatabaseTables.ramyeon.name,
        columu1 = RamyeonTableColumns.tag.name,
        result = columu1.cast<String>(
          (await (await db).query(
            table,
            columns: [columu1],
            where: 'id = ?',
            whereArgs: [id],
          )).first,
        );
    return result.isNotEmpty ? result.split(",").toSet() : .new();
  }
}
