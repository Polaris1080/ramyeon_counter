// Package
import 'package:darq/darq.dart';
import 'package:ramyeon_counter/model/repository/stock_repository.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
// Model
import '../stock_chart_data.dart';
import '../base/context_base.dart';
import '../repository/company_repository.dart';
import '../repository/rating_repository.dart';
import '../../ramyeon_database.dart';

class StockChartDataContext extends RamyeonContextBase {
  @override
  RamyeonDatabaseTable get table => .ramyeon;

  Future<List<StockChartData>> readByBrand() async {
    final database = await db;
    var t1 = (await database.rawQuery(
      "SELECT strftime('%Y', purchaseDate) AS year, SUM(price) AS sum FROM stock GROUP BY strftime('%Y', purchaseDate)", // ORDER BY year ASC",
    ));
    final a = (await database.query(
      table.name,
      where: 'brand Like ?',
      whereArgs: ['%brand%'],
    )).decode();
    return a;
  }
}

class TestRamyeonListContext extends StockChartDataContext {
  @override
  Future<Database> get db => TestRamyeonDatabase().open();
}

extension on List<Map<String, Object?>> {
  Future<List<StockChartData>> decode() async {
    late var r = <StockChartData>[];
    for (final t in this) {
      final id = t['id'] as int, companyId = t['companyId'] as int;
      final (rating, company, stock) = await (
        RatingRepository().readByBrandId(id),
        CompanyRepository().read(companyId),
        StockRepository().readByBrandId(id),
      ).wait;
      r.add(StockChartData(brand: t['brand'] as String, price: []));
    }
    return r;
  }
}
