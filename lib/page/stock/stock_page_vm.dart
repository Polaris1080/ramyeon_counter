// Partial
part of 'package:ramyeon_counter/page/stock/stock_page.dart';

class StockPageViewModel extends ChangeNotifier {
  StockPageViewModel(this.brandId);

  /* Argument */
  final int? brandId;

  /// 情報
  List<StockPostitData>? get source => _source;
  List<StockPostitData>? _source;
  Future loadSource() async {
    final data = (await StockPostitContext().read(brandId));
    _source = data.toList();
    _isSelected = data.select((_, _) => ValueNotifier<bool>(false)).toList();
    notifyListeners();
  }

  /// 選択（状態）
  List<ValueNotifier<bool>> get isSelected => _isSelected;
  late List<ValueNotifier<bool>> _isSelected;
}
