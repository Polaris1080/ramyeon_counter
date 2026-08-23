// Base
import '../../base/column_definition.dart';
import '../../base/table_columns_base.dart';

enum StockTableColumns implements TableColumnsBase {
  id,
  brandId,
  purchaseDate,
  expirationDate,
  price,
  ate;

  static List<ColumnConstraint> get tableDefinition => [
    StockTableColumns.id.integer.primary,
    StockTableColumns.brandId.integer.notnull,
    StockTableColumns.purchaseDate.text.notnull, // DateTime
    StockTableColumns.expirationDate.text.notnull, // DateTime
    StockTableColumns.price.integer.notnull,
    StockTableColumns.ate.integer.notnull, // bool
  ];
}
