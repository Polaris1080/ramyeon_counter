// Base
import '../../base/column_behind.dart';
import '../base/em_castable_query_map.dart';
import '../../base/model_base.dart';

// Table
import '../../database/ramyeon/table/company_table_columns.dart';
import '../../database/ramyeon/table/ramyeon_table_columns.dart';

// Model
import 'company.dart';

class Ramyeon({
  required int id,
  required int companyId,
  required String brand,
  required String company,
  required List<String> tag,
  int? packageColor,
}) extends ModelBase {
  /* Table */
  /// Primary
  int get id => _id.value;

  /// [Company]
  int get companyId => _companyId.value;

  /// 商品
  String get brand => _brand.value;

  ///
  String get company => _company.value;

  /// タグ
  List<String> get tag => _tag.value;

  /// 色（パッケージ）
  int? get packageColor => _packageColor.value;

  /* From:To */
  factory Ramyeon.fromMap(Map<String, Object?> map) => Ramyeon(
    id: RamyeonTableColumns.id.cast<int>(map),
    companyId: RamyeonTableColumns.companyId.cast<int>(map),
    brand: RamyeonTableColumns.brand.cast<String>(map),
    company: RamyeonTableColumns.company.cast<String>(map),
    tag: RamyeonTableColumns.tag.castList<String>(map),
    packageColor: RamyeonTableColumns.packageColor.cast<int?>(map),
  );

  @override
  List<ColumnBehind<Object?>> get columus => [
    _id,
    _companyId,
    _brand,
    _company,
    _tag,
    _packageColor,
  ];

  /* Behind */
  final PrimaryColumnBehind _id = .new(id, RamyeonTableColumns.id);
  final OtherPrimaryColumnBehind _companyId = .new(
    companyId,
    RamyeonTableColumns.companyId,
  );
  final NoValidateColumnBehind<String> _brand = .new(
    brand,
    RamyeonTableColumns.brand,
  );
  @Relation(Company, CompanyTableColumns.company)
  final NoValidateColumnBehind<String> _company = .new(
    company,
    RamyeonTableColumns.company,
    to: (isDB) => null,
  );
  final NoValidateColumnBehind<List<String>> _tag = .new(
    tag,
    RamyeonTableColumns.tag,
    to: (isDB) => isDB ? tag.join(',') : tag,
  );
  final NoValidateColumnBehind<int?> _packageColor = .new(
    packageColor,
    RamyeonTableColumns.packageColor,
  );
}
