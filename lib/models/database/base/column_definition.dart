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

abstract class ColumnConstraint implements TableColumn {
  final TableColumn _columu;
  ColumnConstraint(this._columu);

  @override
  String toString() => _columu.toString();
}

extension TableRowToTableColumn on Enum {
  TableColumn get blob => BlobColumn(name);
  TableColumn get integer => IntColumn(name);
  TableColumn get text => TextColumn(name);
  TableColumn get real => NumColumn(name);
}

extension TableColumnToColumuConstraint on TableColumn {
  ColumnConstraint get primary => PrimaryConstraint(this);
  ColumnConstraint get unique => UniqueConstraint(this);
  ColumnConstraint get notnull => NotNullConstraint(this);
  ColumnConstraint get nullable => NullableConstraint(this);
}
