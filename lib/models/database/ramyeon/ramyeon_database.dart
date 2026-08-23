// Package
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

// Model
import '../../model/ramyeon/repository/company_repository.dart';
import '../../model/ramyeon/repository/ramyeon_repository.dart';
import '../../model/ramyeon/repository/rating_repository.dart';
import '../../model/ramyeon/repository/stock_repository.dart';

class RamyeonDatabase {
  static const dbName = 'ramyeon_database.db',
      dbNameDev = 'ramyeon_database_dev.db';

  Future<Database> open() async {
    databaseFactoryOrNull = null;
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;

    return openDatabase(
      join(await getDatabasesPath(), kReleaseMode ? dbName : dbNameDev),
      version: 1,
      onCreate: (db, version) {
        CompanyRepository().onCreate(db);
        RamyeonRepository().onCreate(db);
        StockRepository().onCreate(db);
        RatingRepository().onCreate(db);
        return;
      },
    );
  }
}

class TestRamyeonDatabase {
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
