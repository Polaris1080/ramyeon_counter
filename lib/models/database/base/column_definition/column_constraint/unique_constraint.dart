part of '../../column_definition.dart';

class UniqueConstraint(super.columu) extends ColumnConstraint {
  @override
  String toString() => "${super.toString()} UNIQUE";
}
