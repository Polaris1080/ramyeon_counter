import '../company.dart';
import '../base/model_base.dart';
import '../../ramyeon_database.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class CompanyRepository extends RamyeonModelBase {
  @override
  RamyeonDatabaseTable get table => .company;

  Future<int> insert(String company) async =>
      await super.insertBase(Company(id: -1, company: company));

  Future<List<Company>> readAll() async => (await readAllBase()).decode();

  Future<Company?> read(int id) async => (await (await db).query(
    table.name,
    where: 'id = ?',
    whereArgs: [id],
  )).decode().firstOrNull;

  Future<Company?> readByCompany(String company) async {
    return (await (await db).query(
      table.name,
      where: 'company = ?',
      whereArgs: [company],
    )).decode().firstOrNull;
  }

  Future<int> update(Company value) async =>
      await updateBase(value, where: 'id = ?', whereArgs: [value.id]);

  Future<int> delete(int id) async =>
      await deleteBase(where: 'id = ?', whereArgs: [id]);

  /// [RamyeonDatabase] onCreate
  Future onCreate(Database db) async {
    await db.execute(
      RamyeonModelBase.sqlCreateTable(table, Company.tableDefinition),
    );
    ['三養', '農心'].asMap().forEach((int i, String v) async {
      db.insert(
        table.name,
        (Company(id: i, company: v).toMap()),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    });
  }
}

class TestCompanyRepository extends CompanyRepository {
  @override
  Future<Database> get db => TestRamyeonDatabase().open();

  /// [TestRamyeonDatabase] onCreate
  @override
  Future onCreate(Database db) async {
    await db.execute(
      RamyeonModelBase.sqlCreateTable(table, Company.tableDefinition),
    );
  }
}

extension on List<Map<String, Object?>> {
  List<Company> decode() => [
    for (final t in this)
      .new(id: t['id'] as int, company: t['company'] as String),
  ];
}
