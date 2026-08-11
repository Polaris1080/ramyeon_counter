// Base
import '../base/annnotation.dart';
import '../base/column_difinition.dart';
import '../base/em_castable_query_map.dart';
import '../base/model_base.dart';
// Table
import '../table/company_table_columns.dart';
import '../table/ramyeon_table_columns.dart';
// Model
import 'ramyeon.dart';

class Company extends ModelBase {
  Company({required int id, required String company})
    : _id = .new(
        value: id,
        column: CompanyTableColumns.id,
        to: (bool isDB) => id >= 0 ? id : null,
      ),
      _company = .new(
        value: company,
        column: CompanyTableColumns.company,
        to: (bool isDB) => company,
      );

  /* Table */
  @PrimaryKey()
  @Relation(Ramyeon, RamyeonTableColumns.companyId)
  ColumnDifinition<int> _id;
  int get id => _id.value;

  /// 会社
  ColumnDifinition<String> _company;
  String get company => _company.value;

  /* From:To */
  factory Company.fromMap(Map<String, Object?> map) => Company(
    id: CompanyTableColumns.id.cast<int>(map),
    company: CompanyTableColumns.company.cast<String>(map),
  );

  @override
  List<ColumnDifinition<Object>> get columus => [_id, _company];
}
