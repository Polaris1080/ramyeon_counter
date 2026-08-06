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
  static ColumuConstraint get _idColumuDefinition =>
      PrimaryConstraint(IntColumn());

  @OtherPrimary(Company)
  final int companyId;
  Object? get _companyIdValue => companyId;
  static ColumuConstraint get _companyIdColumuDefinition =>
      NotNullConstraint(IntColumn());

  /// 商品
  final String brand;
  Object? get _brandValue => brand;
  static ColumuConstraint get _brandColumuDefinition =>
      NotNullConstraint(TextColumn());

  @Relation(Company, CompanyTableRow.company)
  final String company;
  Object? get _companyValue => null;

  /// タグ
  final List<String> tag;
  Object? _tagValue(bool isDB) => isDB ? tag.join(',') : tag;
  static ColumuConstraint get _tagColumuDefinition =>
      NotNullConstraint(TextColumn());

  /// 色（パッケージ）
  final int? packageColor;
  Object? get _packageColorValue => packageColor;
  static ColumuConstraint get _packageColorColumuDefinition =>
      NullConstraint(IntColumn());

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

  static Map<String, ColumuConstraint> get tableDefinition =>
      [
            RamyeonTableRow.id,
            RamyeonTableRow.companyId,
            RamyeonTableRow.brand,
            RamyeonTableRow.tag,
            RamyeonTableRow.packageColor,
          ]
          .select((s, _) => s.name)
          .zip([
            _idColumuDefinition,
            _companyIdColumuDefinition,
            _brandColumuDefinition,
            _tagColumuDefinition,
            _packageColorColumuDefinition,
          ], (k, v) => MapEntry(k, v))
          .toMap((m) => m);
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
