// Partial
part of 'package:ramyeon_counter/page/stock/stock_page.dart';

class StockPageViewModel(final int? brandId) extends ChangeNotifier {
  /// 情報
  @OneWay()
  List<StockPostitData>? get source => _source;
  List<StockPostitData>? _source;
  @protected
  set source(List<StockPostitData> value) {
    _source = value;
    _isSelected = Iterable<ValueNotifier<bool>>.generate(
      value.length,
      (_) => .new(false),
    ).toList();
    notifyListeners();
  }

  Future loadSource() async =>
      source = await StockPostitContext().read(brandId);

  /// 選択（状態）
  @OneWay()
  List<ValueNotifier<bool>> get isSelected => _isSelected;
  late List<ValueNotifier<bool>> _isSelected;
}
