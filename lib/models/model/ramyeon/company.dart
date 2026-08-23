// Base
import '../../base/column_behind.dart';
import '../../base/em_castable_query_map.dart';
import '../../base/model_base.dart';
// Table
import '../../database/ramyeon/table/company_table_columns.dart';
import '../../database/ramyeon/table/ramyeon_table_columns.dart';
// Model
import 'ramyeon.dart';

class Company({required int id, required String company}) extends ModelBase {
  /* Table */
  /// Primary
  int get id => _id.value;

  /// 会社
  String get company => _company.value;

  /* From:To */
  factory Company.fromMap(Map<String, Object?> map) => Company(
    id: CompanyTableColumns.id.cast<int>(map),
    company: CompanyTableColumns.company.cast<String>(map),
  );

  @override
  List<ColumnBehind<Object>> get columus => [_id, _company];

  /* Behind */
  @Relation(Ramyeon, RamyeonTableColumns.companyId)
  final PrimaryColumnBehind _id = .new(id, CompanyTableColumns.id);
  final NoValidateColumnBehind<String> _company = .new(
    company,
    CompanyTableColumns.company,
  );
}
