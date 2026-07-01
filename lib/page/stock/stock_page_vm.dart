import 'dart:async';
import 'package:darq/darq.dart';
import 'package:flutter/material.dart';
import 'package:ramyeon_counter/model/repository/ramyeon_repository.dart';
import 'package:ramyeon_counter/model/repository/stock_repository.dart';
import 'package:ramyeon_counter/page/stock/stock_page.dart';

class StockPageViewModel extends ChangeNotifier {
  StockPageViewModel(this.brandId);

  final int? brandId;

  Future<List<StockPostitViewModel>> get source async =>
      _source ?? await load();
  List<StockPostitViewModel>? _source;

  Future<Map<int, String>> get brandDict async =>
      _brandDict ??
      RamyeonRepository().readAll().then((result) {
        _brandDict = result.toMap((t) => MapEntry(t.id, t.brand));
        notifyListeners();
        return _brandDict!;
      });
  Map<int, String>? _brandDict;

  Future<Map<int, Color?>> get colorDict async =>
      _colorDict ??
      RamyeonRepository().readAll().then((result) {
        _colorDict = result.toMap(
          (t) => MapEntry(
            t.id,
            (t.packageColor is int) ? Color(t.packageColor!) : null,
          ),
        );
        notifyListeners();
        return _colorDict!;
      });

  Map<int, Color?>? _colorDict;

  ///（削除）選択モード
  bool get isSelectMode => _isSelectMode;
  bool _isSelectMode = false;
  set isSelectMode(bool value) {
    if (isSelectMode != value) {
      _isSelectMode = value;
      _source?.forEach((f) => f.isSelectMode = value);
      notifyListeners();
    }
  }

  Future<List<StockPostitViewModel>> load() async {
    final (stock, brand, color) = await (
      brandId != null
          ? StockRepository().readByBrandId(brandId!)
          : StockRepository().readAll(),
      brandDict,
      colorDict,
    ).wait;
    _source = stock
        .where((w) => !(w.ate))
        .select(
          (s, _) => StockPostitViewModel(
            s,
            brandName: brand[s.brandId] ?? "",
            color: color[s.brandId],
          ),
        )
        .toList();
    notifyListeners();
    return _source!;
  }
}
