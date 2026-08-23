// Base
import '../base/column_behind.dart';
import '../base/em_castable_query_map.dart';
import '../base/model_base.dart';
// Table
import '../database/ramyeon/table/company_table_columns.dart';
import '../database/ramyeon/table/ramyeon_table_columns.dart';
// Model
import 'ramyeon.dart';

class Company extends ModelBase {
  Company({required int id, required String company})
    : _id = .new(id, CompanyTableColumns.id),
      _company = .new(company, CompanyTableColumns.company);

  /* Table */
  /// Primary
  @Relation(Ramyeon, RamyeonTableColumns.companyId)
  PrimaryColumnBehind _id;
  int get id => _id.value;

  /// 会社
  NoValidateColumnBehind<String> _company;
  String get company => _company.value;

  /* From:To */
  factory Company.fromMap(Map<String, Object?> map) => Company(
    id: CompanyTableColumns.id.cast<int>(map),
    company: CompanyTableColumns.company.cast<String>(map),
  );

  @override
  List<ColumnBehind<Object>> get columus => [_id, _company];
}
