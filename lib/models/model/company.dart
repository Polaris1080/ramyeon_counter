// Base
import '../base/column_behind.dart';
import '../base/em_castable_query_map.dart';
import '../base/model_base.dart';
// Table
import '../table/ramyeon/company_table_columns.dart';
import '../table/ramyeon/ramyeon_table_columns.dart';
// Model
import 'ramyeon.dart';

class Company extends ModelBase {
  Company({required int id, required String company})
    : _id = PrimaryColumnBehind(id, CompanyTableColumns.id),
      _company = .noValidate(company, CompanyTableColumns.company);

  /* Table */
  @Relation(Ramyeon, RamyeonTableColumns.companyId)
  ColumnBehind<int> _id;
  int get id => _id.value;

  /// 会社
  ColumnBehind<String> _company;
  String get company => _company.value;

  /* From:To */
  factory Company.fromMap(Map<String, Object?> map) => Company(
    id: CompanyTableColumns.id.cast<int>(map),
    company: CompanyTableColumns.company.cast<String>(map),
  );

  @override
  List<ColumnBehind<Object>> get columus => [_id, _company];
}
