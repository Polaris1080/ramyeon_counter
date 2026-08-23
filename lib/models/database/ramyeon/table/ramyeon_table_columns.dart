// Base
import '../../base/column_definition.dart';
import '../../base/table_columns_base.dart';

enum RamyeonTableColumns implements TableColumnsBase{
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
