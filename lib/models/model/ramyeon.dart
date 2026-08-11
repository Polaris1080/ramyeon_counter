// Base
import '../base/annnotation.dart';
import '../base/column_difinition.dart';
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
  }) : _id = .new(
         value: id,
         column: RamyeonTableColumns.id,
         to: (bool isDB) => id >= 0 ? id : null,
       ),
       _companyId = .new(
         value: companyId,
         column: RamyeonTableColumns.companyId,
         to: (bool isDB) => companyId,
         validator: () => companyId < 0,
         error: RangeError.value(
           companyId,
           RamyeonTableColumns.companyId.name,
           '${RamyeonTableColumns.companyId.name} >= 0',
         ),
       ),
       _brand = .new(
         value: brand,
         column: RamyeonTableColumns.brand,
         to: (isDB) => brand,
       ),
       _company = .new(
         value: company,
         column: RamyeonTableColumns.company,
         to: (isDB) => null,
       ),
       _tag = .new(
         value: tag,
         column: RamyeonTableColumns.tag,
         to: (isDB) => isDB ? tag.join(',') : tag,
       ),
       _packageColor = .new(
         value: packageColor,
         column: RamyeonTableColumns.packageColor,
         to: (isDB) => packageColor,
       );

  /* Table */
  @PrimaryKey()
  final ColumnDifinition<int> _id;
  int get id => _id.value;

  @OtherPrimary(Company)
  final ColumnDifinition<int> _companyId;
  int get companyId => _companyId.value;

  /// 商品
  final ColumnDifinition<String> _brand;
  String get brand => _brand.value;

  @Relation(Company, CompanyTableColumns.company)
  final ColumnDifinition<String> _company;
  String get company => _company.value;

  /// タグ
  final ColumnDifinition<List<String>> _tag;
  List<String> get tag => _tag.value;

  /// 色（パッケージ）
  final ColumnDifinition<int?> _packageColor;
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
  List<ColumnDifinition<Object?>> get columus => [
    _id,
    _companyId,
    _brand,
    _company,
    _tag,
    _packageColor,
  ];
}
