// Base
import '../base/annnotation.dart';
import '../base/model_base.dart';
import '../base/table_difinition.dart';
// Model
import 'ramyeon.dart';
// Package
import 'package:darq/darq.dart';

class Company extends ModelBase {
  Company({required this.id, required this.company});

  /* Table */
  @PrimaryKey()
  @Relation(Ramyeon, RamyeonTableRow.companyId)
  final int id;
  Object? get _idValue => id >= 0 ? id : null;
  static ColumuConstraint get _idColumuDefinition =>
      PrimaryConstraint(IntColumn());

  /// 会社
  final String company;
  Object? get _companyValue => company;
  static ColumuConstraint get _companyColumuDefinition =>
      NotNullConstraint(TextColumn());

  /* From:To */
  factory Company.fromMap(Map<String, Object?> map) => Company(
    id: map[CompanyTableRow.id.name] as int,
    company: map[CompanyTableRow.company.name] as String,
  );

  @override
  Map<String, Object?> toMap({bool isDB = false}) {
    validate();
    return CompanyTableRow.values
        .select((s, _) => s.name)
        .zip(<Object?>[
          _idValue,
          _companyValue,
        ], (key, value) => MapEntry(key, value))
        .toMap((m) => m);
  }

  @override
  String? validate() => null;

  static Map<String, ColumuConstraint> get tableDefinition => CompanyTableRow
      .values
      .select((s, _) => s.name)
      .zip([
        _idColumuDefinition,
        _companyColumuDefinition,
      ], (k, v) => MapEntry(k, v))
      .toMap((m) => m);
}

enum CompanyTableRow {
  /// INTEGER(int) PrimaryKey
  id,

  /// TEXT(String)
  company,
}
