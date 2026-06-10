import 'company_repository.dart';
import '../ramyeon.dart';
import '../base/model_base.dart';
import '../../ramyeon_database.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class RamyeonRepository extends RamyeonModelBase {
  @override
  RamyeonDatabaseTable get table => .ramyeon;

  Future<int> insert(Ramyeon value) async => await super.insertBase(value);

  Future<List<Ramyeon>> readAll() async => (await readAllBase()).decode();

  Future<Ramyeon> read(int id) async => (await (await (await db).query(
    table.name,
    where: 'id = ?',
    whereArgs: [id],
  )).decode()).first;

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

  /// [RamyeonDatabase] onCreate
  Future onCreate(Database db) async {
    db.execute(RamyeonModelBase.sqlCreateTable(table, Ramyeon.tableDefinition));
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
      RamyeonModelBase.sqlCreateTable(table, Ramyeon.tableDefinition),
    );
  }
}

extension on List<Map<String, Object?>> {
  // DarQは非同期に非対応
  Future<List<Ramyeon>> decode() async {
    late var r = <Ramyeon>[];
    for (final t in this) {
      final companyId = t['companyId'] as int;
      final company = (await CompanyRepository().read(companyId))!.company;
      r.add(
        Ramyeon(
          id: t['id'] as int,
          companyId: companyId,
          brand: t['brand'] as String,
          company: company,
          tag: (t['tag'] as String).split(','),
          packageColor: t['packageColor'] as int?,
        ),
      );
    }
    return r;
  }
}
