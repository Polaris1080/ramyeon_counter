import '../table_column_difinition.dart';

enum StockTableColumns {
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
