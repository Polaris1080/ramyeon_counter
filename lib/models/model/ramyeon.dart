// Base
import '../base/model_annnotations.dart';
import '../base/column_behind.dart';
import '../base/em_castable_query_map.dart';
import '../base/model_base.dart';
// Table
import '../table/ramyeon/company_table_columns.dart';
import '../table/ramyeon/ramyeon_table_columns.dart';
// Model
import 'company.dart';

class Ramyeon extends ModelBase {
  Ramyeon({
    required int id,
    required int companyId,
    required String brand,
    required String company,
    required List<String> tag,
    int? packageColor,
  }) : _id = PrimaryColumnBehind(id, RamyeonTableColumns.id),
       _companyId = OtherPrimaryColumnBehind(
         companyId,
         RamyeonTableColumns.companyId,
       ),
       _brand = .noValidate(brand, RamyeonTableColumns.brand),
       _company = .noValidate(
         company,
         RamyeonTableColumns.company,
         to: (isDB) => null,
       ),
       _tag = .noValidate(
         tag,
         RamyeonTableColumns.tag,
         to: (isDB) => isDB ? tag.join(',') : tag,
       ),
       _packageColor = .noValidate(
         packageColor,
         RamyeonTableColumns.packageColor,
       );

  /* Table */
  final ColumnBehind<int> _id;
  int get id => _id.value;

  @OtherPrimary(Company)
  final ColumnBehind<int> _companyId;
  int get companyId => _companyId.value;

  /// 商品
  final ColumnBehind<String> _brand;
  String get brand => _brand.value;

  @Relation(Company, CompanyTableColumns.company)
  final ColumnBehind<String> _company;
  String get company => _company.value;

  /// タグ
  final ColumnBehind<List<String>> _tag;
  List<String> get tag => _tag.value;

  /// 色（パッケージ）
  final ColumnBehind<int?> _packageColor;
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
}
