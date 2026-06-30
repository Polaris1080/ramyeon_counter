part of './stock_page.dart';

class StockPostitViewModel extends ChangeNotifier {
  int count = 0;

  StockPostitViewModel(Stock stock) {
    this.stock = stock;
    _brandId = stock.brandId;
    notifyListeners();
  }

  int get brandId => _brandId;
  late final int _brandId;

  late Stock stock;

  bool selectVisible = true;

  bool get selected => _selected;
  bool _selected = false;
  set selected(bool value) {
    if (_selected != value) {
      _selected = value;
      notifyListeners();
    }
  }
}
