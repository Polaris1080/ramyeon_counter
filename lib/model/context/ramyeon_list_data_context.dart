// Package
import 'package:darq/darq.dart';
import 'package:ramyeon_counter/model/repository/stock_repository.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
// Model
import '../ramyeon_list_data.dart';
import '../base/context_base.dart';
import '../repository/company_repository.dart';
import '../repository/rating_repository.dart';
import '../../ramyeon_database.dart';

class RamyeonListDataContext extends RamyeonContextBase {
  RamyeonDatabaseTable get table => .ramyeon;

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
