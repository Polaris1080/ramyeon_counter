// Package
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
// Other
import '../../database/ramyeon/ramyeon_database.dart';

abstract class ContextBase {}

abstract class RamyeonContextBase extends ContextBase {
  Future<Database> get db => RamyeonDatabase().open();
}
