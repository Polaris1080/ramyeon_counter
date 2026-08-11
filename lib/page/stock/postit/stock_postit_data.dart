// Model
import 'package:ramyeon_counter/models/table/ramyeon_database_tables.dart';
import 'package:ramyeon_counter/models/table/ramyeon/ramyeon_table_columns.dart';
import 'package:ramyeon_counter/models/table/ramyeon/stock_table_columns.dart';
import 'package:ramyeon_counter/ramyeon_database.dart';
import 'package:ramyeon_counter/models/model/ramyeon.dart';
import 'package:ramyeon_counter/models/model/stock.dart';
import 'package:ramyeon_counter/models/base/context_base.dart';
import 'package:ramyeon_counter/models/base/model_base.dart';
// Package
import 'package:darq/darq.dart';
import 'package:flutter/material.dart';
// Partial
part 'stock_postit_context.dart';

class StockPostitData extends VirtualModelBase {
  /// [Stock].id
  final int id;

  /// 商品名
  final String brand;

  /// 購入日
  final DateTime purchaseDate;

  /// 賞味期限
  final DateTime expirationDate;

  /// 購入価格
  final int price;

  /// 色
  final Color? color;

  StockPostitData({
    required this.id,
    required this.brand,
    required this.purchaseDate,
    required this.expirationDate,
    required this.price,
    this.color,
  });
}
