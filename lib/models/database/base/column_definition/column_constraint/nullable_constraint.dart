part of '../../column_definition.dart';

class NullableConstraint(super.columu) extends ColumnConstraint {
  @override
  String toString() => "${super.toString()} NULL";
}
