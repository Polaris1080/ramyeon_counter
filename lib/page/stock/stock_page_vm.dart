part of 'package:ramyeon_counter/page/stock/stock_page.dart';

class StockPageViewModel(final int? brandId) extends ChangeNotifier {
  /// 情報
  @OneWay()
  List<StockPostitData>? get source => _source;
  List<StockPostitData>? _source;
  @protected
  set source(List<StockPostitData> value) {
    final isSelectedLength = value.length; // source.length == isSelected.length
    _source = value;
    _isSelected = Iterable<ValueNotifier<bool>>.generate(
      isSelectedLength,
      (_) => .new(false),
    ).toList();
    notifyListeners();
  }

  Future loadSource() async =>
      source = await StockPostitContext().read(brandId);

  /// 選択（状態）
  @OneWay()
  List<ValueNotifier<bool>>? get isSelected => _isSelected;
  List<ValueNotifier<bool>>? _isSelected;

  @OneWay()
  int get isSelectedCount => isSelected != null
      ? isSelected!.count((isSelected) => isSelected.value)
      : 0;

  @TwoWay()
  bool get isSelectMode => _isSelectMode;
  bool _isSelectMode = false;
  set isSelectMode(bool value) {
    if (_isSelectMode != value) {
      _isSelectMode = value;
      isSelected!.forEach((f) => f.value = false);
      notifyListeners();
    }
  }
}
