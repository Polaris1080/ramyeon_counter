import '../table_column_difinition.dart';

enum CompanyTableColumns {
  id,
  company;

  static List<ColumnConstraint> get tableDefinition => [
    CompanyTableColumns.id.integer.primary,
    CompanyTableColumns.company.integer.notnull,
  ];
}
