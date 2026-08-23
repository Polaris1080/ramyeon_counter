// Base
import '../../base/repository_base.dart';
import '../../database/ramyeon/ramyeon_database_tables.dart';
import '../../table/ramyeon/rating_table_columns.dart';
import '../../../ramyeon_database.dart';
// Extention-Type
import 'package:ramyeon_counter/utility/extension_type/ramyeon_id.dart';
// Model
import '../rating.dart';
import '../stock.dart';
// Package
import 'package:darq/darq.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class RatingRepository extends RamyeonRepositoryBase {
  @override
  RamyeonDatabaseTables get table => .rating;

  Future<int> insert(Rating value) async => insertBase(value);

  Future<List<Rating>> readByBrandId(int brandId) async =>
      (await (await db).query(
        table.name,
        where: '${RatingTableColumns.brandId.name} = ?',
        whereArgs: [brandId],
      )).decode();

  Future<List<Rating>> readAll() async => (await readAllBase()).decode();

  Future<int> update(Rating value) async => await updateBase(
    value,
    where: '${RatingTableColumns.id.name} = ?',
    whereArgs: [value.id],
  );

  Future<int> delete(int id) async => await deleteBase(
    where: '${RatingTableColumns.id.name} = ?',
    whereArgs: [id],
  );

  Future consume(RamyeonId id, int rating) async {
    await (await db).transaction((txn) async {
      // await txn.insert(
      //   'rating',
      //   Rating(
      //     id: -1,
      //     brandId: id.value,
      //     rating: rating,
      //     date: DateTime.now(),
      //   ).toMap(isDB: true),
      // );
      final t1 = (await txn.query(
        'stock',
        where: 'brandId = ? and ate = 0',
        whereArgs: [id],
        orderBy: 'id',
        limit: 1,
      )).select((s, _) => Stock.fromMap(s)).toList().first;
      await txn.update('stock', t1.toMap(isDB: true));
    });
  }

  Future<int> countByBrandId(int brandId) async => (await (await db).rawQuery(
    '''
    SELECT COUNT(*) as count FROM ${table.name}
      WHERE ${RatingTableColumns.brandId.name} = ?
    ''',
    [brandId],
  )).select((s, _) => s['count'] as int).first;

  Future<int> getLastYear() async => (await (await db).rawQuery('''
    SELECT strftime('%Y', date) as lastyear FROM rating ORDER BY date LIMIT 1;
    ''')).select((s, _) => s['lastyear'] as int).first;

  /// [RamyeonDatabase] onCreate
  Future onCreate(Database db) async {
    db.execute(
      RamyeonRepositoryBase.sqlCreateTable(
        table,
        RatingTableColumns.tableDefinition,
      ),
    );
    for (Rating x in [
      .new(id: 0, brandId: 0, rating: 6, date: DateTime(2026, 4, 11)),
      .new(id: 1, brandId: 0, rating: 8, date: DateTime(2026, 4, 12)),
      .new(id: 2, brandId: 0, rating: 10, date: DateTime(2026, 4, 13)),
      .new(id: 3, brandId: 2, rating: 9, date: DateTime(2026, 4, 4)),
    ]) {
      db.insert(
        table.name,
        x.toMap(isDB: true),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }
}

class TestRatingRepository extends RatingRepository {
  @override
  Future<Database> get db => TestRamyeonDatabase().open();

  /// [TestRamyeonDatabase] onCreate
  @override
  Future onCreate(Database db) async {
    await db.execute(
      RamyeonRepositoryBase.sqlCreateTable(
        table,
        RatingTableColumns.tableDefinition,
      ),
    );
  }
}

extension on List<Map<String, Object?>> {
  List<Rating> decode() => [...select((s, _) => Rating.fromMap(s))];
}
