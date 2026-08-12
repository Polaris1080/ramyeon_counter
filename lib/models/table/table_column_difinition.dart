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

/* Base */
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

/* Columu */
class IntColumn implements TableColumn {
  IntColumn(this.columnName);
  final String columnName;
  @override
  String toString() => "$columnName INTEGER";
}

class NumColumn implements TableColumn {
  NumColumn(this.columnName);
  final String columnName;
  @override
  String toString() => "$columnName REAL";
}

class TextColumn implements TableColumn {
  TextColumn(this.columnName);
  final String columnName;
  @override
  String toString() => "$columnName TEXT";
}

class BlobColumn implements TableColumn {
  BlobColumn(this.columnName);
  final String columnName;
  @override
  String toString() => "$columnName BLOB";
}

/* Constraint */
class PrimaryConstraint extends ColumnConstraint {
  PrimaryConstraint(super.columu);

  @override
  String toString() => "${super.toString()} PRIMARY KEY";
}

class UniqueConstraint extends ColumnConstraint {
  UniqueConstraint(super.columu);

  @override
  String toString() => "${super.toString()} UNIQUE";
}

class NotNullConstraint extends ColumnConstraint {
  NotNullConstraint(super.columu);

  @override
  String toString() => "${super.toString()} NOT NULL";
}

class NullableConstraint extends ColumnConstraint {
  NullableConstraint(super.columu);

  @override
  String toString() => "${super.toString()} NULL";
}
