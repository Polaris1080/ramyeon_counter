// Base
import 'column_difinition.dart';
import 'table_difinition.dart';
// Package
import 'package:darq/darq.dart';

/// Model 'not' exist table
abstract class VirtualModelBase {}

/// Model exist table
abstract class ModelBase extends VirtualModelBase {
  static List<ColumuConstraint> get tableDefinition => [];

  List<ColumnDifinition<Object?>> get columus;

  Map<String, Object?> toMap({bool isDB = false}) {
    columus.forEach((e) => e.validate());
    return columus.toMap((t) => t.toEntry(isDB));
  }

  @override
  String toString() =>
      '$runtimeType{${toMap().entries.select((s, _) => '${s.key}: ${s.value}').join(', ')}}';
}
