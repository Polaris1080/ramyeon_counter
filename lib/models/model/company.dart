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

  /// 会社
  final String company;
  Object? get _companyValue => company;

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

  static List<ColumuConstraint> get tableDefinition => [
    CompanyTableRow.id.integer.primary,
    CompanyTableRow.company.integer.notnull,
  ];
}

enum CompanyTableRow {
  /// INTEGER(int) PrimaryKey
  id,

  /// TEXT(String)
  company,
}
