// Package
import 'package:flutter/foundation.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
// Other
import 'model_base.dart';
import '../../ramyeon_database.dart';

abstract class ContextBase {
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
  static Future<List<Map<String, Object?>>> readAllTagData(
    Database db,
    String table,
  ) async => await db.query(table);
}

abstract class RamyeonContextBase extends ContextBase {
  Future<Database> get db => RamyeonDatabase().open();

  @protected
  Future<int> insertBase(
    RamyeonDatabaseTable table,
    ModelBase value, {
    String? nullColumnHack,
    ConflictAlgorithm? conflictAlgorithm,
  }) async => await ContextBase.insert(
    await db,
    table.name,
    value.toMap(isDB: true),
    nullColumnHack: nullColumnHack,
    conflictAlgorithm: conflictAlgorithm,
  );

  @protected
  Future<List<Map<String, Object?>>> readAllBase(
    RamyeonDatabaseTable table,
  ) async => await ContextBase.readAllTagData(await db, table.name);

  @protected
  Future<int> updateBase(
    RamyeonDatabaseTable table,
    ModelBase value, {
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
  Future<int> deleteBase(
    RamyeonDatabaseTable table, {
    String? where,
    List<Object?>? whereArgs,
  }) async =>
      await (await db).delete(table.name, where: where, whereArgs: whereArgs);
}
