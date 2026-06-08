import 'package:darq/darq.dart';
import 'package:flutter/material.dart';
import 'package:ramyeon_counter/model/ramyeon.dart';
import 'package:ramyeon_counter/model/rating.dart';
import 'package:ramyeon_counter/model/repository/rating_repository.dart';
import 'package:ramyeon_counter/model/stock.dart';
import 'package:ramyeon_counter/model/repository/stock_repository.dart';

class RamyeonTileViewModel extends ChangeNotifier {
  final int id;
  final String brand;

  List<Stock>? _stock;
  List<Stock>? get stock => _stock;
  set stock(List<Stock> value) {
    _stock = value;
    var remain = value.where((stock) => !(stock.ate));
    count = remain.count();
    limit = remain
        .distinct()
        .orderBy((o) => {o.expirationDate})
        .firstOrNull
        ?.expirationDate;
    price = remain.isNotEmpty
        ? remain.select((x, _) => x.price).average()
        : null;
    notifyListeners();
  }

  List<Rating>? _rating;
  List<Rating>? get rating => _rating;
  set rating(List<Rating>? value) {
    _rating = value;
    rate = value!.isNotEmpty ? value.average((r) => r.rating) : double.nan;
    notifyListeners();
  }

  // [Catalog]
  String catalogModeText = '';
  int? count;
  DateTime? limit;
  // [Normal]
  String normalModeText = '';
  double? rate;
  int? price;

  Ramyeon? ramyeon;

  RamyeonTileViewModel(this.id, this.brand) {
    StockRepository().readByBrandId(id).then((s) => {stock = s});
    RatingRepository().readByBrandId(id).then((r) => {rating = r});
    notifyListeners();
  }
  RamyeonTileViewModel.fromModel(Ramyeon this.ramyeon)
    : id = ramyeon.id,
      brand = ramyeon.brand {
    StockRepository().readByBrandId(id).then((s) => {stock = s});
    RatingRepository().readByBrandId(id).then((r) => {rating = r});
    notifyListeners();
  }
}
