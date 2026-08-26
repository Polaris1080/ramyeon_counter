/// @docImport 'package:ramyeon_counter/models/model/ramyeon/stock.dart';
library;

// Base
import 'package:ramyeon_counter/models/base/model_base.dart';
import 'package:ramyeon_counter/models/context/base/context_base.dart';

// Extension
import 'package:ramyeon_counter/models/model/base/em_castable_query_map.dart';

// Package
import 'package:flutter/material.dart';

// Model
import 'package:ramyeon_counter/models/database/ramyeon/ramyeon_database_tables.dart';
import 'package:ramyeon_counter/models/database/ramyeon/table/ramyeon_table_columns.dart';
import 'package:ramyeon_counter/models/database/ramyeon/table/stock_table_columns.dart';

class StockPostitData({
  /// [Stock].id
  required final int id,

  /// 商品名
  required final String brand,

  /// 購入日
  required final DateTime purchaseDate,

  /// 賞味期限
  required final DateTime expirationDate,

  /// 購入価格
  required final int price,

  /// 色
  final Color? color,
}) extends VirtualModelBase {
  factory StockPostitData.fromMap(Map<String, Object?> map) => StockPostitData(
    id: StockTableColumns.id.cast(map),
    brand: RamyeonTableColumns.brand.cast(map),
    purchaseDate: StockTableColumns.expirationDate.castDateTime(map),
    expirationDate: StockTableColumns.expirationDate.castDateTime(map),
    price: StockTableColumns.price.cast(map),
    color: switch (RamyeonTableColumns.packageColor.cast<int?>(map)) {
      int color => Color(color),
      _ => null,
    },
  );
}

class StockPostitContext extends RamyeonContextBase {
  Future<List<StockPostitData>> read(int? brandId) async => [
    ...(await (await db).rawQuery('''
        SELECT s.*,
               r.${RamyeonTableColumns.brand.name},
               r.${RamyeonTableColumns.packageColor.name}
        FROM ${RamyeonDatabaseTables.stock.name}   as s
        JOIN ${RamyeonDatabaseTables.ramyeon.name} as r 
        ON    s.${StockTableColumns.brandId.name} = r.${RamyeonTableColumns.id.name}
        where s.${StockTableColumns.ate.name} = 0
        ${brandId is int ? 'and s.${StockTableColumns.brandId.name} = $brandId' : ''};
      ''')).map((map) => StockPostitData.fromMap(map)),
  ];
}
