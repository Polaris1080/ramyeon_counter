import '../../table_columns_base.dart';

enum BarcodeTableColumns {
  id,
  brandId,
  count,
  jam;

  static List<ColumnConstraint> get tableDefinition => [
    BarcodeTableColumns.id.integer.primary,
    BarcodeTableColumns.brandId.integer.notnull,
    BarcodeTableColumns.count.integer.notnull, // >=1
    BarcodeTableColumns.jam.integer.notnull, // digit=8|13
  ];
}
