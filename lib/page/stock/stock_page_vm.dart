// Partial
part of 'package:ramyeon_counter/page/stock/stock_page.dart';

class StockPageViewModel extends ChangeNotifier {
  StockPageViewModel(this.brandId);

  /* Value */
  final int? brandId;

  /// 情報
  Future<List<StockPostitData>> get source async => _source ?? await load();
  List<StockPostitData>? _source;
  set source(List<StockPostitData> value) {
    source = value;
    notifyListeners();
  }

  List<ValueNotifier<bool>> isSelected = [];

  Future<List<StockPostitData>> load() async {
    _source = (await StockPostitContext().read(brandId: brandId)).toList();
    notifyListeners();
    return _source!;
  }
}
