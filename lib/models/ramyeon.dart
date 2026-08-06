// Base
import 'base/model_base.dart';
import 'base/em_table_definition.dart';
// Model
import 'company.dart';

class Ramyeon extends ModelBase {
  /// [Ramyeon].id
  /// PrimaryKey (>= 0)
  final int id;

  /// [Company].id
  /// >= 0 (PrimaryKey)
  final int companyId;

  /// 商品
  final String brand;

  /// [Company].company *会社*
  final String company;

  /// タグ
  final List<String> tag;

  /// 色（パッケージ）
  final int? packageColor;

  Ramyeon({
    required this.id,
    required this.companyId,
    required this.brand,
    required this.company,
    required this.tag,
    this.packageColor,
  });

  Ramyeon.toInsert({
    required this.id,
    required this.brand,
    required this.company,
    required this.tag,
    this.packageColor,
  }) : companyId = -1;

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
    if (companyId < 0) {
      throw RangeError.value(
        companyId,
        RamyeonTableRow.brand.name,
        '${RamyeonTableRow.brand.name} >= 0',
      );
    }
    return <String, Object?>{
      // INTEGER(int)PrimaryKey
      RamyeonTableRow.id.name: id >= 0 ? id : null,
      // INTEGER(int)
      RamyeonTableRow.companyId.name: companyId,
      // TEXT(String)
      RamyeonTableRow.brand.name: brand,
      // TEXT | List<String>
      RamyeonTableRow.tag.name: isDB ? tag.join(',') : tag,
      // INTEGER(int?)
      RamyeonTableRow.packageColor.name: packageColor,
    };
  }

  static List<String> get tableDefinition => [
    RamyeonTableRow.id.name.integer.primary,
    RamyeonTableRow.companyId.name.integer.notnull,
    RamyeonTableRow.brand.name.text.notnull,
    RamyeonTableRow.tag.name.text.notnull,
    RamyeonTableRow.packageColor.name.integer,
  ];
}

enum RamyeonTableRow { id, companyId, brand, company, tag, packageColor }
