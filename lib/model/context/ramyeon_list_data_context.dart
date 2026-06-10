import 'package:darq/darq.dart';
import 'package:ramyeon_counter/model/ramyeon_list_data.dart';
import 'package:ramyeon_counter/model/repository/rating_repository.dart';

import '../base/context_base.dart';
import '../repository/company_repository.dart';
import '../ramyeon.dart';
import '../base/model_base.dart';
import '../../ramyeon_database.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class RamyeonListDataContext extends RamyeonContextBase {
  @override
  RamyeonDatabaseTable get table => .ramyeon;

  // Future<int> insert(Ramyeon value) async => await super.insertBase(value);

  // Future<List<Ramyeon>> readAll() async => (await readAllBase()).decode();

  // Future<Ramyeon> read(int id) async => (await (await (await db).query(
  //   table.name,
  //   where: 'id = ?',
  //   whereArgs: [id],
  // )).decode()).first;

  Future<List<RamyeonListData>> readByBrand(String brand) async {
    final database = await db;
    final a = (await database.query(
      table.name,
      where: 'brand Like ?',
      whereArgs: ['%$brand%'],
    )).decode();
    return a;
  }

  // Future<int> update(Ramyeon value) async =>
  //     await updateBase(value, where: 'id = ?', whereArgs: [value.id]);

  // Future<int> delete(int id) async =>
  //     await deleteBase(where: 'id = ?', whereArgs: [id]);
}

class TestRamyeonListContext extends RamyeonListDataContext {
  @override
  Future<Database> get db => TestRamyeonDatabase().open();

  /// [TestRamyeonDatabase] onCreate
  @override
  Future onCreate(Database db) async {
    await db.execute(
      RamyeonModelBase.sqlCreateTable(table, Ramyeon.tableDefinition),
    );
  }
}

extension on List<Map<String, Object?>> {
  Future<List<RamyeonListData>> decode() async {
    late var r = <RamyeonListData>[];
    for (final t in this) {
      final id = t['id'] as int, companyId = t['companyId'] as int;
      final (rating, company) = await (
        RatingRepository().readByBrandId(id),
        CompanyRepository().read(companyId),
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
        ),
      );
    }
    return r;
  }
}
