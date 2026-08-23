// Base
import '../base/database_tables_base.dart';

// Table
import './table/barcode_table_columns.dart';
import './table/company_table_columns.dart';
import './table/ramyeon_table_columns.dart';
import './table/rating_table_columns.dart';
import './table/stock_table_columns.dart';

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
