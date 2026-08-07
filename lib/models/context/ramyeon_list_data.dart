// Base
import '../base/model_base.dart';
// Model
import '../model/company.dart';
import '../model/ramyeon.dart';

class RamyeonListData extends VirtualModelBase {
  RamyeonListData({
    required this.id,
    required this.companyId,
    required this.brand,
    required this.company,
    required this.tag,
    this.packageColor,
    required this.rating,
    required this.count,
  });

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

  /// 個数
  final int count;
}
