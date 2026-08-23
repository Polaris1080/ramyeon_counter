// Base
import 'table_columns_base.dart';
// TableColumn
part 'column_definition/table_column/blob_column.dart';
part 'column_definition/table_column/int_column.dart';
part 'column_definition/table_column/num_column.dart';
part 'column_definition/table_column/text_column.dart';
// ColumnConstraint
part 'column_definition/column_constraint/not_null_constraint.dart';
part 'column_definition/column_constraint/nullable_constraint.dart';
part 'column_definition/column_constraint/primary_constraint.dart';
part 'column_definition/column_constraint/unique_constraint.dart';

abstract class TableColumn {
  @override
  String toString();
}

/// [TableColumnsBase] to [TableColumn]
extension TableColumnsBaseToTableColumn on Enum {
  TableColumn get blob => BlobColumn(name);
  TableColumn get integer => IntColumn(name);
  TableColumn get text => TextColumn(name);
  TableColumn get real => NumColumn(name);
}

abstract class ColumnConstraint(final TableColumn _columu)
    implements TableColumn {
  @override
  String toString() => _columu.toString();
}

/// [TableColumn] to [ColumnConstraint]
extension TableColumnToColumnConstraint on TableColumn {
  ColumnConstraint get primary => PrimaryConstraint(this);
  ColumnConstraint get unique => UniqueConstraint(this);
  ColumnConstraint get notnull => NotNullConstraint(this);
  ColumnConstraint get nullable => NullableConstraint(this);
}
