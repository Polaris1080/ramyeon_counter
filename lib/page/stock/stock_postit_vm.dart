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
}
