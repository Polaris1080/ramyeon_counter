part of '../../column_definition.dart';

class BlobColumn(final String columnName) implements TableColumn {
  @override
  String toString() => "$columnName BLOB";
}
