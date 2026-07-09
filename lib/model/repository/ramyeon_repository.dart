import 'package:darq/darq.dart';

import 'company_repository.dart';
import '../ramyeon.dart';
import '../base/repository_base.dart';
import '../../ramyeon_database.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class RamyeonRepository extends RamyeonRepositoryBase {
  @override
  RamyeonDatabaseTable get table => .ramyeon;

  Future<int> insert(Ramyeon value) async => await super.insertBase(value);

  Future<List<Ramyeon>> readAll() async => await (await (await db).rawQuery(
    'SELECT * FROM ramyeon INNER JOIN company ON ramyeon.companyId = company.id',
  )).decode();

  Future<Ramyeon> read(int id) async => (await (await (await db).rawQuery(
    'SELECT * FROM ramyeon INNER JOIN company ON ramyeon.companyId = company.id WHERE ramyeon.id = ? ',
    [id],
  )).decode()).first;

  Future<List<String>?> readTag(int id) async {
    return ((await (await db).rawQuery(
      'SELECT tag FROM ramyeon  INNER JOIN company ON ramyeon.companyId = company.id WHERE ramyeon.id = ?',
      [id],
    )).select((s, _) => (s['tag'] as String).split(','))).firstOrNull;
  }

  Future<List<Ramyeon>> readByBrand(String brand) async =>
      (await (await db).query(
        table.name,
        where: 'brand Like ?',
        whereArgs: ['%$brand%'],
      )).decode();

  Future<int> update(Ramyeon value) async =>
      await updateBase(value, where: 'id = ?', whereArgs: [value.id]);

  Future<int> delete(int id) async =>
      await deleteBase(where: 'id = ?', whereArgs: [id]);

  Future<int> countByBrand(String brand) async {
    var result = await (await db).rawQuery(
      'SELECT COUNT(*) as count FROM ${table.name} WHERE brand Like ?',
      ['%$brand%'],
    );
    var t1 = result.select((s, _) => s['count'] as int).first;
    return t1;
  }

  /// [RamyeonDatabase] onCreate
  Future onCreate(Database db) async {
    db.execute(
      RamyeonRepositoryBase.sqlCreateTable(table, Ramyeon.tableDefinition),
    );
    for (Ramyeon seed in [
      .new(
        id: 0,
        companyId: 1,
        brand: '辛ラーメン',
        company: '農心',
        packageColor: 0xFFFF3f3f,
        tag: ['ゆでる', 'からい'],
      ),
      .new(
        id: 1,
        companyId: 1,
        brand: 'ノグリ',
        company: '農心',
        tag: ['ゆでる', 'からくない'],
      ),
      .new(
        id: 2,
        companyId: 0,
        brand: '三養ラーメン',
        company: '三養',
        packageColor: 0xFF00ff7f,
        tag: ['ゆでる', 'からくない'],
      ),
      .new(
        id: 3,
        companyId: 0,
        brand: 'ブルダック麺',
        company: '三養',
        tag: ['いためる', 'とてもからい'],
      ),
      .new(
        id: 4,
        companyId: 0,
        brand: 'カルボブルダック麺',
        company: '三養',
        tag: ['いためる', 'とてもからい', 'カルボナーラ'],
      ),
      .new(
        id: 5,
        companyId: 0,
        brand: 'クリームカルボブルダック麺',
        company: '三養',
        tag: ['いためる', 'とてもからい', 'カルボナーラ', 'クリーム'],
      ),
    ]) {
      db.insert(
        table.name,
        seed.toMap(isDB: true),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }
}

class TestRamyeonRepository extends RamyeonRepository {
  @override
  Future<Database> get db => TestRamyeonDatabase().open();

  /// [TestRamyeonDatabase] onCreate
  @override
  Future onCreate(Database db) async {
    await db.execute(
      RamyeonRepositoryBase.sqlCreateTable(table, Ramyeon.tableDefinition),
    );
  }
}

extension on List<Map<String, Object?>> {
  List<Ramyeon> decode() => select((s, _) => Ramyeon.fromMap(s)).toList();
}
