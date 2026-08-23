// Base
import '../../base/model_base.dart';

class StockChartData extends VirtualModelBase {
  StockChartData({required this.brand, required this.price});

  /// 商品
  final String brand;

  /// 価格（合計）
  final List<int> price;
}
