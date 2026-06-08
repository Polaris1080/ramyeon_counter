import 'i_mapperble.dart';
import '../../ramyeon_database.dart';
import 'package:flutter/foundation.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

abstract class ModelBase {
  @protected
  static Future<int> insert(
    Database db,
    String table,
    Map<String, Object?> values, {
    String? nullColumnHack,
    ConflictAlgorithm? conflictAlgorithm = .replace,
  }) async => await db.insert(
    table,
    values,
    nullColumnHack: nullColumnHack,
    conflictAlgorithm: conflictAlgorithm,
  );

  @protected
  static Future<List<Map<String, Object?>>> readAll(
    Database db,
    String table,
  ) async => await db.query(table);

  static String sqlCreateTable(String table, List<String> tableDefinition) =>
      'CREATE TABLE $table(${tableDefinition.join(', ')})';
}

abstract class RamyeonModelBase extends ModelBase {
  Future<Database> get db => RamyeonDatabase().open();

  abstract final RamyeonDatabaseTable table;

  @protected
  Future<int> insertBase(
    IMapperble value, {
    String? nullColumnHack,
    ConflictAlgorithm? conflictAlgorithm,
  }) async => await ModelBase.insert(
    await db,
    table.name,
    value.toMap(isDB: true),
    nullColumnHack: nullColumnHack,
    conflictAlgorithm: conflictAlgorithm,
  );

  @protected
  Future<List<Map<String, Object?>>> readAllBase() async =>
      await ModelBase.readAll(await db, table.name);

  @protected
  Future<int> updateBase(
    IMapperble value, {
    String? where,
    List<Object?>? whereArgs,
    ConflictAlgorithm? conflictAlgorithm,
  }) async => await (await db).update(
    table.name,
    value.toMap(),
    where: where,
    whereArgs: whereArgs,
  );

  @protected
  Future<int> deleteBase({String? where, List<Object?>? whereArgs}) async =>
      await (await db).delete(table.name, where: where, whereArgs: whereArgs);

  static String sqlCreateTable(
    RamyeonDatabaseTable table,
    List<String> tableDefinition,
  ) => ModelBase.sqlCreateTable(table.name, tableDefinition);
}
