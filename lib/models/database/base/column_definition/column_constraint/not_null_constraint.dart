part of '../../column_definition.dart';

class NotNullConstraint(super.columu) extends ColumnConstraint {
  @override
  String toString() => "${super.toString()} NOT NULL";
}
