// Partial
part of 'package:ramyeon_counter/page/stock/stock_page.dart';

class StockPageViewModel extends ChangeNotifier {
  StockPageViewModel(this.brandId);

  /* Value */
  final int? brandId;

  /// 情報
  Future<List<StockPostitViewModel>> get source async =>
      _source ?? await load();
  List<StockPostitViewModel>? _source;
  set source(List<StockPostitViewModel> value) {
    source = value;
    notifyListeners();
  }

  List<ValueNotifier<bool>> isSelected = [];

  /// 企業（対照）
  Future<Map<int, String>> get brandDict async =>
      _brandDict ??
      RamyeonRepository().readAll().then((result) {
        _brandDict = result.toMap(
          (ramyeon) => MapEntry(ramyeon.id, ramyeon.brand),
        );
        notifyListeners();
        return _brandDict!;
      });
  Map<int, String>? _brandDict;

  /// 色（対照）
  Future<Map<int, Color?>> get colorDict async =>
      _colorDict ??
      RamyeonRepository().readAll().then((result) {
        _colorDict = result.toMap((ramyeon) {
          final int? color = ramyeon.packageColor;
          return MapEntry(ramyeon.id, color != null ? Color(color) : null);
        });
        notifyListeners();
        return _colorDict!;
      });
  Map<int, Color?>? _colorDict;

  Future<List<StockPostitViewModel>> load() async {
    const emptyBrand = '-';
    final repo = StockRepository();
    final (stock, brand, color) = await (
      brandId != null ? repo.readByBrandId(brandId!) : repo.readAll(),
      brandDict,
      colorDict,
    ).wait;
    _source = stock.where((stock) => !(stock.ate)).select((stock, _) {
      final id = stock.brandId;
      return StockPostitViewModel(
        stock,
        brandName: brand[id] ?? emptyBrand,
        color: color[id],
      );
    }).toList();
    notifyListeners();
    return _source!;
  }
}
