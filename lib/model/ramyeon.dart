import 'base/model_base.dart';
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

  @override
  Map<String, Object?> toMap({bool isDB = false}) {
    if (companyId < 0) {
      throw RangeError.value(companyId, 'brandId', 'brandId >= 0');
    }
    return <String, Object?>{
      // INTEGER(int)PrimaryKey
      'id': id >= 0 ? id : null,
      // INTEGER(int)
      'companyId': companyId,
      // TEXT(String)
      'brand': brand,
      // TEXT | List<String>
      'tag': isDB ? tag.join(',') : tag,
      // INTEGER(int?)
      'packageColor': packageColor,
    };
  }

  static List<String> get tableDefinition => [
    'id INTEGER PRIMARY KEY',
    'companyId INTEGER not null',
    'brand TEXT not null',
    'tag TEXT not null',
    'packageColor INTEGER',
  ];
}
