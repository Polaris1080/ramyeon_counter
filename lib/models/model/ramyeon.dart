// Base
import '../base/annnotation.dart';
import '../base/model_base.dart';
import '../base/table_difinition.dart';
// Model
import 'company.dart';
// Package
import 'package:darq/darq.dart';

class Ramyeon extends ModelBase {
  Ramyeon({
    required this.id,
    required this.companyId,
    required this.brand,
    required this.company,
    required this.tag,
    this.packageColor,
  });

  /* Table */
  @PrimaryKey()
  final int id;
  Object? get _idValue => id >= 0 ? id : null;

  @OtherPrimary(Company)
  final int companyId;
  Object? get _companyIdValue => companyId;

  /// 商品
  final String brand;
  Object? get _brandValue => brand;

  @Relation(Company, CompanyTableRow.company)
  final String company;
  Object? get _companyValue => null;

  /// タグ
  final List<String> tag;
  Object? _tagValue(bool isDB) => isDB ? tag.join(',') : tag;

  /// 色（パッケージ）
  final int? packageColor;
  Object? get _packageColorValue => packageColor;

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
  Map<String, Object?> toMap({bool isDB = false}) {
    validate();
    return RamyeonTableRow.values
        .select((s, _) => s.name)
        .zip(<Object?>[
          _idValue,
          _companyIdValue,
          _brandValue,
          _companyValue,
          _tagValue(isDB),
          _packageColorValue,
        ], (key, value) => MapEntry(key, value))
        .toMap((m) => m);
  }

  @override
  String? validate() {
    if (companyId < 0) {
      throw RangeError.value(
        companyId,
        RamyeonTableRow.brand.name,
        '${RamyeonTableRow.brand.name} >= 0',
      );
    }
    return null;
  }

  static List<ColumuConstraint> get tableDefinition => [
    RamyeonTableRow.id.int.primary,
    RamyeonTableRow.companyId.int.notnull,
    RamyeonTableRow.brand.text.notnull,
    RamyeonTableRow.tag.text.notnull,
    RamyeonTableRow.packageColor.int.nullable,
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
