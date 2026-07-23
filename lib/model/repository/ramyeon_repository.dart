// Base
import '../base/repository_base.dart';
import '../../ramyeon_database.dart';
// Extention
import 'package:ramyeon_counter/utility/extention_type/ramyeon_id.dart';
// Model
import '../company.dart';
import '../ramyeon.dart';
// Package
import 'package:darq/darq.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class RamyeonRepository extends RamyeonRepositoryBase {
  @override
  RamyeonDatabaseTable get table => .ramyeon;
  static const RamyeonDatabaseTable _subTable = .company;

  Future<int> insert(Ramyeon value) async => await super.insertBase(value);

  Future<List<Ramyeon>> readAll() async => (await (await db).rawQuery('''
    SELECT * FROM ${table.name} INNER JOIN ${_subTable.name}
      ON ${table.name}.${RamyeonTableRow.companyId.name} = ${_subTable.name}.${CompanyTableRow.id.name}
  ''')).decode();

  Future<Ramyeon> read(int id) async => ((await (await db).rawQuery(
    '''
    SELECT * FROM ${table.name} INNER JOIN ${_subTable.name}
      ON ${table.name}.${RamyeonTableRow.companyId.name} = ${_subTable.name}.${CompanyTableRow.id.name}
      WHERE ${table.name}.${RamyeonTableRow.id.name} = ?
    ''',
    [id],
  )).decode()).first;

  Future<List<String>?> readTag(RamyeonId id) async =>
      ((await (await db).query(
            table.name,
            columns: ['tag'],
            where: '${RamyeonTableRow.id.name} = ?',
            whereArgs: [id],
          )).select(
            (s, _) => [
              ...(s['tag'] as String).split(',').where((w) => w.isNotEmpty),
            ],
          ))
          .firstOrNull;

  Future<int> update(Ramyeon value) async => await updateBase(
    value,
    where: '${RamyeonTableRow.id.name} = ?',
    whereArgs: [value.id],
  );

  Future<int> delete(int id) async => await deleteBase(
    where: '${RamyeonTableRow.id.name} = ?',
    whereArgs: [id],
  );

  Future<int> countByBrand(String brand) async => (await (await db).rawQuery(
    '''
    SELECT COUNT(*) as count FROM ${table.name}
      WHERE ${RamyeonTableRow.brand.name} Like ?
    ''',
    ['%$brand%'],
  )).select((s, _) => s['count'] as int).first;

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
