// Base
import '../../base/repository_base.dart';
import '../../../ramyeon_database.dart';
// Model
import '../barcode.dart';
// Package
import 'package:darq/darq.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class BarcodeRepository extends RamyeonRepositoryBase {
  @override
  RamyeonDatabaseTable get table => .barcode;

  Future<int> insert(Barcode value) async => insertBase(value);

  Future<List<Barcode>> readByBrandId(int brandId) async =>
      (await (await db).query(
        table.name,
        where: '${BarcodeTableRow.brandid.name} = ?',
        whereArgs: [brandId],
      )).decode();

  Future<List<Barcode>> readAll() async => (await readAllBase()).decode();

  Future<int> update(Barcode value) async => await updateBase(
    value,
    where: '${BarcodeTableRow.id.name} = ?',
    whereArgs: [value.id],
  );

  Future<int> delete(int id) async => await deleteBase(
    where: '${BarcodeTableRow.id.name} = ?',
    whereArgs: [id],
  );

  /// [RamyeonDatabase] onCreate
  void onCreate(Database db) async {
    db.execute(
      RamyeonRepositoryBase.sqlCreateTable(table, Barcode.tableDefinition),
    );
    for (Barcode x in [
      // ちょうど手元にあった
      .new(id: 0, brandId: 5, count: 1, jam: 8801073114920),
      .new(id: 1, brandId: 5, count: 5, jam: 8801073143319),
    ]) {
      db.insert(
        table.name,
        x.toMap(isDB: true),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }
}

class TestBarcodeRepository extends BarcodeRepository {
  @override
  Future<Database> get db => TestRamyeonDatabase().open();

  /// [TestRamyeonDatabase] onCreate
  @override
  Future onCreate(Database db) async {
    await db.execute(
      RamyeonRepositoryBase.sqlCreateTable(table, Barcode.tableDefinition),
    );
  }
}

extension on List<Map<String, Object?>> {
  List<Barcode> decode() => select((s, _) => Barcode.fromMap(s)).toList();
}
