// Base
import 'column_behind.dart';
import '../table/table_column_difinition.dart';

/// Model 'not' exist table
abstract class VirtualModelBase {}

/// Model exist table
abstract class ModelBase extends VirtualModelBase {
  List<ColumnBehind<Object?>> get columus;

  static List<ColumnConstraint> get tableDefinition => [];

  Map<String, Object?> toMap({bool isDB = false}) {
    columus.forEach((e) => e.validate());
    return Map.fromEntries(columus.map((s) => s.toEntry(isDB)));
  }

  @override
  String toString() =>
      '$runtimeType{${toMap().entries.map((s) => '${s.key}: ${s.value}').join(', ')}}';
}
