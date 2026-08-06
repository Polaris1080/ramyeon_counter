abstract class TableColumn {
  @override
  String toString();
}

abstract class ColumuConstraint implements TableColumn {
  final TableColumn _columu;
  ColumuConstraint(this._columu);

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
class PrimaryConstraint extends ColumuConstraint {
  PrimaryConstraint(super.columu);

  @override
  String toString() => "${super.toString()} PRIMARY KEY";
}

class UniqueConstraint extends ColumuConstraint {
  UniqueConstraint(super.columu);

  @override
  String toString() => "${super.toString()} UNIQUE";
}

class NotNullConstraint extends ColumuConstraint {
  NotNullConstraint(super.columu);

  @override
  String toString() => "${super.toString()} NOT NULL";
}

class NullConstraint extends ColumuConstraint {
  NullConstraint(super.columu);

  @override
  String toString() => "${super.toString()} ";
}
