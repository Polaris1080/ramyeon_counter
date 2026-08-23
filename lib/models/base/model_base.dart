// Base
import 'column_behind.dart';
import '../database/base/column_definition.dart';

// Package
import 'package:meta/meta_meta.dart';

/// Model 'not' exist table
abstract class VirtualModelBase;

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

// Model Annotations
@Target({TargetKind.field})
class const Relation(final Type table, final dynamic columu);
