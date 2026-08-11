extension TableRowToTableColumn on Enum {
  TableColumn get blob => BlobColumn();
  TableColumn get integer => IntColumn();
  TableColumn get text => TextColumn();
  TableColumn get real => NumColumn();
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
  @override
  String toString() => " INTEGER";
}

class NumColumn implements TableColumn {
  @override
  String toString() => " REAL";
}

class TextColumn implements TableColumn {
  @override
  String toString() => " TEXT";
}

class BlobColumn implements TableColumn {
  @override
  String toString() => " BLOB";
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
