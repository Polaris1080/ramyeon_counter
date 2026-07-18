part of './stock_page.dart';

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

  /// 選択状態
  bool get selected => _selected;
  bool _selected = false;
  set selected(bool value) {
    if (_selected != value) {
      _selected = value;
      notifyListeners();
    }
  }
}
