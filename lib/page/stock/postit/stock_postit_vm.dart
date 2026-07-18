part of '../stock_page.dart';

class StockPostitViewModel extends Stock with ChangeNotifier {
  StockPostitViewModel(
    super.stock, {
    required String brandName,
    required this.color,
  }) : title = brandName,
       super.self();

  /// 色
  final Color? color;

  /// 見出し
  final String title;
}
