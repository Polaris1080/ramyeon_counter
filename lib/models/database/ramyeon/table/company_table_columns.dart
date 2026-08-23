// Base
import '../../base/column_definition.dart';
import '../../base/table_columns_base.dart';

enum CompanyTableColumns implements TableColumnsBase{
  id,
  company;

  static List<ColumnConstraint> get tableDefinition => [
    CompanyTableColumns.id.integer.primary,
    CompanyTableColumns.company.integer.notnull,
  ];
}
