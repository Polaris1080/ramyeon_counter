// Base
import 'package:ramyeon_counter/models/table/ramyeon_database_tables.dart';

import '../../base/repository_base.dart';
import '../../table/company_table_columns.dart';
import '../../../ramyeon_database.dart';
// Model
import '../company.dart';
// Package
import 'package:darq/darq.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class CompanyRepository extends RamyeonRepositoryBase {
  @override
  RamyeonDatabaseTables get table => .company;

  Future<int> insert(String company) async =>
      await super.insertBase(Company(id: -1, company: company));

  Future<List<Company>> readAll() async => (await readAllBase()).decode();

  Future<Company?> read(int id) async => (await (await db).query(
    table.name,
    where: '${CompanyTableColumns.id.name} = ?',
    whereArgs: [id],
  )).decode().firstOrNull;

  Future<Company?> readByCompany(String company) async {
    return (await (await db).query(
      table.name,
      where: '${CompanyTableColumns.company.name} = ?',
      whereArgs: [company],
    )).decode().firstOrNull;
  }

  Future<int> update(Company value) async => await updateBase(
    value,
    where: '${CompanyTableColumns.id.name} = ?',
    whereArgs: [value.id],
  );

  Future<int> delete(int id) async => await deleteBase(
    where: '${CompanyTableColumns.id.name} = ?',
    whereArgs: [id],
  );

  /// [RamyeonDatabase] onCreate
  Future onCreate(Database db) async {
    await db.execute(
      RamyeonRepositoryBase.sqlCreateTable(
        table,
        CompanyTableColumns.tableDefinition,
      ),
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
      RamyeonRepositoryBase.sqlCreateTable(
        table,
        CompanyTableColumns.tableDefinition,
      ),
    );
  }
}

extension on List<Map<String, Object?>> {
  List<Company> decode() => [...select((s, _) => Company.fromMap(s))];
}
