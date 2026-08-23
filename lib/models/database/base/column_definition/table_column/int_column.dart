part of '../../column_definition.dart';

class IntColumn(final String columnName) implements TableColumn {
  @override
  String toString() => "$columnName INTEGER";
}
