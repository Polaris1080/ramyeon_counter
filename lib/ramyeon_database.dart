import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'model/repository/company_repository.dart';
import 'model/repository/ramyeon_repository.dart';
import 'model/repository/rating_repository.dart';
import 'model/repository/stock_repository.dart';

class RamyeonDatabase {
  static const String dbName = 'ramyeon_database.db';
  static const String dbNameDev = 'ramyeon_database_dev.db';

  Future<Database> open() async {
    // databaseFactory = databaseFactoryFfi;
    // databaseFactoryOrNull = databaseFactoryFfi;
    databaseFactoryOrNull = null;
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;

    return openDatabase(
      join(await getDatabasesPath(), kReleaseMode ? dbName : dbNameDev),
      onCreate: (db, version) {
        CompanyRepository().onCreate(db);
        RamyeonRepository().onCreate(db);
        StockRepository().onCreate(db);
        RatingRepository().onCreate(db);
        return;
      },
      version: 1,
    );
  }
}

class TestRamyeonDatabase {
  static const String dbName = 'ramyeon_database.db';
  static const String dbNameDev = 'ramyeon_database_dev.db';

  Future<Database> open() async {
    databaseFactoryOrNull = null;
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
    return openDatabase(
      inMemoryDatabasePath,
      version: 1,
      onCreate: (db, version) async {
        TestCompanyRepository().onCreate(db);
      },
    );
  }
}

enum RamyeonDatabaseTable { barcode, company, ramyeon, rating, stock }
