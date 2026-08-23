// Base
import '../../base/context_base.dart';
import '../../../database/ramyeon/ramyeon_database.dart';
import '../../../database/ramyeon/ramyeon_database_tables.dart';

// Package
import 'package:darq/darq.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

// Context
import '../ramyeon_list_data.dart';

// Model
import '../../../model/ramyeon/repository/company_repository.dart';
import '../../../model/ramyeon/repository/rating_repository.dart';
import '../../../model/ramyeon/repository/stock_repository.dart';

/// [RamyeonListData] code behind
class RamyeonListDataContext extends RamyeonContextBase {
  RamyeonDatabaseTables get table => .ramyeon;

  Future<List<RamyeonListData>> readByBrand(
    String brand, {
    String? order,
  }) async {
    final database = await db;
    final a = (await database.query(
      table.name,
      orderBy: order,
      where: 'brand Like ?',
      whereArgs: ['%$brand%'],
    )).decode();
    return a;
  }

  Future<List<RamyeonListData>> read(String brand, {String? order}) async {
    final database = await db;
    final a = (await database.query(
      table.name,
      orderBy: order,
      where: 'brand Like ?',
      whereArgs: ['%$brand%'],
    )).decode();
    return a;
  }
}

class TestRamyeonListContext extends RamyeonListDataContext {
  @override
  Future<Database> get db => TestRamyeonDatabase().open();
}

extension on List<Map<String, Object?>> {
  Future<List<RamyeonListData>> decode() async {
    late var r = <RamyeonListData>[];
    for (final t in this) {
      final id = t['id'] as int, companyId = t['companyId'] as int;
      final (rating, company, stock) = await (
        RatingRepository().readByBrandId(id),
        CompanyRepository().read(companyId),
        StockRepository().readByBrandId(id),
      ).wait;
      r.add(
        RamyeonListData(
          id: id,
          companyId: companyId,
          brand: t['brand'] as String,
          company: company!.company,
          tag: (t['tag'] as String).split(','),
          packageColor: t['packageColor'] as int?,
          rating: rating.isNotEmpty
              ? rating.average((r) => r.rating).toDouble()
              : double.nan,
          count: stock.isNotEmpty ? stock.count((x) => x.ate) : 0,
        ),
      );
    }
    return r;
  }
}
