// Base
import 'table_difinition.dart';
// Package
import 'package:darq/darq.dart';

/// Model 'not' exist table
abstract class VirtualModelBase {}

/// Model exist table
abstract class ModelBase extends VirtualModelBase {
  static List<ColumuConstraint> get tableDefinition => [];

  Map<String, Object?> toMap({bool isDB = false});

  String? validate();

  @override
  String toString() =>
      '$runtimeType{${toMap().entries.select((s, _) => '${s.key}: ${s.value}').join(', ')}}';
}
