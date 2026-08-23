part of '../../column_definition.dart';

class TextColumn(final String columnName) implements TableColumn {
  @override
  String toString() => "$columnName TEXT";
}
