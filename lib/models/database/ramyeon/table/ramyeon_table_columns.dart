import '../../table_columns_definition.dart';

enum RamyeonTableColumns {
  id,
  companyId,
  brand,
  company,
  tag,
  packageColor;

  static List<ColumnConstraint> get tableDefinition => [
    RamyeonTableColumns.id.integer.primary,
    RamyeonTableColumns.companyId.integer.notnull,
    RamyeonTableColumns.brand.text.notnull,
    RamyeonTableColumns.tag.text.notnull, // List<String>
    RamyeonTableColumns.packageColor.integer.nullable,
  ];
}
