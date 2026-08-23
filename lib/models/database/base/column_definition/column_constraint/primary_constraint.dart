part of '../../column_definition.dart';

class PrimaryConstraint(super.columu) extends ColumnConstraint {
  @override
  String toString() => "${super.toString()} PRIMARY KEY";
}
