// Base
import '../../base/model_base.dart';

class StockChartData({
  /// 商品
  required final String brand,

  /// 価格（合計）
  required final List<int> price,
}) extends VirtualModelBase;
