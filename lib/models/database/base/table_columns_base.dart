// Package
import 'package:meta/meta.dart';

// Base
import 'column_definition.dart';

abstract class TableColumnsBase {
  @mustBeOverridden
  static List<ColumnConstraint> get tableDefinition => [];
}
