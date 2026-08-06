abstract class TableColumn {
  @override
  String toString();
}

abstract class ColumuConstraint implements TableColumn {
  final TableColumn coffee;
  ColumuConstraint(this.coffee);

  @override
  String toString() => coffee.toString();
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
  PrimaryConstraint(super.coffee);

  @override
  String toString() => "${super.toString()} PRIMARY KEY";
}

class UniqueConstraint extends ColumuConstraint {
  UniqueConstraint(super.coffee);

  @override
  String toString() => "${super.toString()} UNIQUE";
}

class NotNullConstraint extends ColumuConstraint {
  NotNullConstraint(super.coffee);

  @override
  String toString() => "${super.toString()} NOT NULL";
}

class NullConstraint extends ColumuConstraint {
  NullConstraint(super.coffee);

  @override
  String toString() => "${super.toString()} ";
}
