// Base
import '../base/annnotation.dart';
import '../base/column_difinition.dart';
import '../base/model_base.dart';
import '../base/table_difinition.dart';
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
         column: RamyeonTableRow.id,
         to: (bool isDB) => id >= 0 ? id : null,
       ),
       _companyId = .new(
         value: companyId,
         column: RamyeonTableRow.companyId,
         to: (bool isDB) => companyId,
         validator: () => companyId < 0,
         error: RangeError.value(
           companyId,
           RamyeonTableRow.companyId.name,
           '${RamyeonTableRow.companyId.name} >= 0',
         ),
       ),
       _brand = .new(
         value: brand,
         column: RamyeonTableRow.brand,
         to: (isDB) => brand,
       ),
       _company = .new(
         value: company,
         column: RamyeonTableRow.company,
         to: (isDB) => null,
       ),
       _tag = .new(
         value: tag,
         column: RamyeonTableRow.tag,
         to: (isDB) => isDB ? tag.join(',') : tag,
       ),
       _packageColor = .new(
         value: packageColor,
         column: RamyeonTableRow.packageColor,
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

  @Relation(Company, CompanyTableRow.company)
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
    id: map[RamyeonTableRow.id.name] as int,
    companyId: map[RamyeonTableRow.companyId.name] as int,
    brand: map[RamyeonTableRow.brand.name] as String,
    company: map[RamyeonTableRow.company.name] as String,
    tag: (map[RamyeonTableRow.tag.name] as String).split(','),
    packageColor: map[RamyeonTableRow.packageColor.name] as int?,
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

  static List<ColumuConstraint> get tableDefinition => [
    RamyeonTableRow.id.integer.primary,
    RamyeonTableRow.companyId.integer.notnull,
    RamyeonTableRow.brand.text.notnull,
    RamyeonTableRow.tag.text.notnull,
    RamyeonTableRow.packageColor.integer.nullable,
  ];
}

enum RamyeonTableRow {
  /// INTEGER(int) PrimaryKey
  id,

  /// INTEGER(int)
  companyId,

  /// TEXT(String)
  brand,

  ///
  company,

  /// TEXT | `List<String>`
  tag,

  /// INTEGER(int?)
  packageColor,
}
