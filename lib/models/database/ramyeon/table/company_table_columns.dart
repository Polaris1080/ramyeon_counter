import '../../table_columns_base.dart';

enum CompanyTableColumns {
  id,
  company;

  static List<ColumnConstraint> get tableDefinition => [
    CompanyTableColumns.id.integer.primary,
    CompanyTableColumns.company.integer.notnull,
  ];
}
