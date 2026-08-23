// Base
import '../../base/model_base.dart';
// Model
import '../../model/ramyeon/company.dart';
import '../../model/ramyeon/ramyeon.dart';

class RamyeonListData({
  /// [Ramyeon].id
  required final int id,

  /// [Company].id
  required final int companyId,

  /// 商品
  required final String brand,

  /// [Company].company *会社*
  required final String company,

  /// タグ
  required final List<String> tag,

  /// 色（パッケージ）
  final int? packageColor,

  /// 評価（平均）
  required final double? rating,

  /// 個数
  required final int count,
}) extends VirtualModelBase;
