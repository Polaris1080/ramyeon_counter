// Base
import '../base/model_base.dart';

class StockChartData extends VirtualModelBase {
  /// 商品
  final String brand;

  /// 価格（合計）
  final List<int> price;

  StockChartData({required this.brand, required this.price});
}
