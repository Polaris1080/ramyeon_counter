// Base
import '../base/annnotation.dart';
import '../base/model_base.dart';
import '../base/em_table_definition.dart';
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

  /// 会社
  final String company;

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
          id >= 0 ? id : null,
          company,
        ], (key, value) => MapEntry(key, value))
        .toMap((m) => m);
  }

  @override
  String? validate() => null;

  static List<String> get tableDefinition => [
    CompanyTableRow.id.name.integer.primary,
    CompanyTableRow.company.name.text.notnull,
  ];
}

enum CompanyTableRow {
  /// INTEGER(int) PrimaryKey
  id,

  /// TEXT(String)
  company,
}
