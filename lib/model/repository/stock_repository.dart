import 'package:darq/darq.dart';

import '../stock.dart';
import '../base/model_base.dart';
import '../../ramyeon_database.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class StockRepository extends RamyeonModelBase {
  @override
  RamyeonDatabaseTable get table => .stock;

  Future<int> insert(Stock value) async => insertBase(value);

  Future<List<Stock>> readByBrandId(int brandId) async =>
      (await (await db).query(
        table.name,
        where: 'brandId = ?',
        whereArgs: [brandId],
      )).decode();

  Future<List<Stock>> readAll() async => (await readAllBase()).decode();

  Future<int> update(Stock value) async =>
      await updateBase(value, where: 'id = ?', whereArgs: [value.id]);

  Future<int> delete(int id) async =>
      await deleteBase(where: 'id = ?', whereArgs: [id]);

  /// [RamyeonDatabase] onCreate
  void onCreate(Database db) async {
    db.execute(RamyeonModelBase.sqlCreateTable(table, Stock.tableDefinition));
    for (Stock x in [
      .new(
        id: 0,
        brandId: 0,
        purchaseDate: DateTime(2026, 3, 14),
        expirationDate: DateTime(2026, 4, 13),
        price: 120,
      ),
      .new(
        id: 1,
        brandId: 1,
        purchaseDate: DateTime(2026, 4, 1),
        expirationDate: DateTime(2026, 8, 15),
        price: 133,
        ate: true,
      ),
      .new(
        id: 2,
        brandId: 1,
        purchaseDate: DateTime(2026, 4, 1),
        expirationDate: DateTime(2026, 8, 15),
        price: 133,
      ),
      .new(
        id: 3,
        brandId: 1,
        purchaseDate: DateTime(2026, 4, 1),
        expirationDate: DateTime(2026, 8, 15),
        price: 133,
      ),
      .new(
        id: 4,
        brandId: 2,
        purchaseDate: DateTime(2026, 3, 14),
        expirationDate: DateTime(2026, 8, 31),
        price: 198,
      ),
    ]) {
      db.insert(
        table.name,
        x.toMap(isDB: true),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }
}

class TestStockRepository extends StockRepository {
  @override
  Future<Database> get db => TestRamyeonDatabase().open();

  /// [TestRamyeonDatabase] onCreate
  @override
  Future onCreate(Database db) async {
    await db.execute(
      RamyeonModelBase.sqlCreateTable(table, Stock.tableDefinition),
    );
  }
}

extension on List<Map<String, Object?>> {
  List<Stock> decode() => [
    for (final t in this)
      .new(
        id: t['id'] as int,
        brandId: t['brandId'] as int,
        purchaseDate: DateTime.parse(t['purchaseDate'] as String),
        expirationDate: DateTime.parse(t['expirationDate'] as String),
        price: t['price'] as int,
        ate: t['ate'] as int > 0,
      ),
  ];
}
