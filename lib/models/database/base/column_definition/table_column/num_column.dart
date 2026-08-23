part of '../../column_definition.dart';

class NumColumn(final String columnName) implements TableColumn {
  @override
  String toString() => "$columnName REAL";
}
