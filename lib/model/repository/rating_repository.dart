import '../rating.dart';
import '../base/repository_base.dart';
import '../../ramyeon_database.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class RatingRepository extends RamyeonRepositoryBase {
  @override
  RamyeonDatabaseTable get table => .rating;

  Future<int> insert(Rating value) async => insertBase(value);

  Future<List<Rating>> readByBrandId(int brandId) async =>
      (await (await db).query(
        table.name,
        where: 'brandId = ?',
        whereArgs: [brandId],
      )).decode();

  Future<List<Rating>> readAll() async => (await readAllBase()).decode();

  Future<int> update(Rating value) async =>
      await updateBase(value, where: 'id = ?', whereArgs: [value.id]);

  Future<int> delete(int id) async =>
      await deleteBase(where: 'id = ?', whereArgs: [id]);

  /// [RamyeonDatabase] onCreate
  Future onCreate(Database db) async {
    db.execute(
      RamyeonRepositoryBase.sqlCreateTable(table, Rating.tableDefinition),
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
      RamyeonRepositoryBase.sqlCreateTable(table, Rating.tableDefinition),
    );
  }
}

extension on List<Map<String, Object?>> {
  List<Rating> decode() => [
    for (final t in this)
      .new(
        id: t['id'] as int,
        brandId: t['brandId'] as int,
        rating: t['rating'] as int,
        date: DateTime.parse(t['date'] as String),
      ),
  ];
}
