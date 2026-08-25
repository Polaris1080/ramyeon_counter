/// @docImport './table/barcode_table_columns.dart';
/// @docImport './table/company_table_columns.dart';
/// @docImport './table/ramyeon_table_columns.dart';
/// @docImport './table/rating_table_columns.dart';
/// @docImport './table/stock_table_columns.dart';
library;

// Base
import '../base/database_tables_base.dart';

enum RamyeonDatabaseTables implements DatabaseTablesBase {
  /// [BarcodeTableColumns]
  barcode,

  /// [CompanyTableColumns]
  company,

  /// [RamyeonTableColumns]
  ramyeon,

  /// [RatingTableColumns]
  rating,

  /// [StockTableColumns]
  stock,
}
