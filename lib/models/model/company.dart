// Base
import '../base/annnotation.dart';
import '../base/column_difinition.dart';
import '../base/model_base.dart';
import '../base/table_difinition.dart';
// Model
import 'ramyeon.dart';

class Company extends ModelBase {
  Company({required int id, required String company})
    : _id = .new(
        value: id,
        column: CompanyTableRow.id,
        to: (bool isDB) => id >= 0 ? id : null,
      ),
      _company = .new(
        value: company,
        column: CompanyTableRow.company,
        to: (bool isDB) => company,
      );

  /* Table */
  @PrimaryKey()
  @Relation(Ramyeon, RamyeonTableRow.companyId)
  ColumnDifinition<int> _id;
  int get id => _id.value;

  /// 会社
  ColumnDifinition<String> _company;
  String get company => _company.value;

  /* From:To */
  factory Company.fromMap(Map<String, Object?> map) => Company(
    id: map[CompanyTableRow.id.name] as int,
    company: map[CompanyTableRow.company.name] as String,
  );

  @override
  List<ColumnDifinition<Object>> get columus => [_id, _company];

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
