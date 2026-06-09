import 'base/i_mapperble.dart';
import 'company.dart';

class RamyeonListData implements IMapperble {
  /// [Ramyeon].id
  final int id;

  /// [Company].id
  final int companyId;

  /// 商品
  final String brand;

  /// [Company].company *会社*
  final String company;

  /// タグ
  final List<String> tag;

  /// 色（パッケージ）
  final int? packageColor;

  /// 評価（平均）
  final double? rating;

  RamyeonListData({
    required this.id,
    required this.companyId,
    required this.brand,
    required this.company,
    required this.tag,
    this.packageColor,
    required this.rating,
  });

  RamyeonListData.toInsert({
    required this.id,
    required this.brand,
    required this.company,
    required this.tag,
    this.packageColor,
  }) : companyId = -1,
       rating = 0;

  @override
  Map<String, Object?> toMap({bool isDB = false}) {
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

  @override
  String toString() =>
      'Ramyeon{'
      'id: $id, '
      'companyId: $companyId, '
      'brand: $brand, '
      'tag: ${tag.join(',')}, '
      'company: $company'
      '}';
}
