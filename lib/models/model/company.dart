// Base
import '../base/model_base.dart';
import '../base/em_table_definition.dart';
// Model
import 'ramyeon.dart';

class Company extends ModelBase {
  /// [Company].id & [Ramyeon].companyId
  /// PrimaryKey (>= 0)
  final int id;

  /// 会社
  final String company;

  Company({required this.id, required this.company});

  /* From:To */
  factory Company.fromMap(Map<String, Object?> map) => Company(
    id: map[CompanyTableRow.id.name] as int,
    company: map[CompanyTableRow.company.name] as String,
  );

  @override
  Map<String, Object?> toMap({bool isDB = false}) => {
    // INTEGER(int)PrimaryKey
    CompanyTableRow.id.name: id >= 0 ? id : null,
    // TEXT(String)
    CompanyTableRow.company.name: company,
  };

  static List<String> get tableDefinition => [
    CompanyTableRow.id.name.integer.primary,
    CompanyTableRow.company.name.text.notnull,
  ];
}

enum CompanyTableRow { id, company }
