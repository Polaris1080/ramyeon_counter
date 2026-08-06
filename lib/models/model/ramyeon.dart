// Base
import '../base/annnotation.dart';
import '../base/model_base.dart';
import '../base/em_table_definition.dart';
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

  @OtherPrimary(Company)
  final int companyId;

  /// 商品
  final String brand;

  @Relation(Company, CompanyTableRow.company)
  final String company;

  /// タグ
  final List<String> tag;

  /// 色（パッケージ）
  final int? packageColor;

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
          id >= 0 ? id : null,
          companyId,
          brand,
          null,
          isDB ? tag.join(',') : tag,
          packageColor,
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

  static List<String> get tableDefinition => [
    RamyeonTableRow.id.name.integer.primary,
    RamyeonTableRow.companyId.name.integer.notnull,
    RamyeonTableRow.brand.name.text.notnull,
    RamyeonTableRow.tag.name.text.notnull,
    RamyeonTableRow.packageColor.name.integer,
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
