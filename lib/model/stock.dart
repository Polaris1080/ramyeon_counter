// Base
import 'base/model_base.dart';
import 'base/em_table_definition.dart';
// Model
import 'ramyeon.dart';

/// 在庫（情報）
class Stock extends ModelBase {
  /// [Stock].id
  /// PrimaryKey (>= 0)
  final int id;

  /// [Ramyeon].id
  /// >= 0 (PrimaryKey)
  final int brandId;

  /// 購入日
  final DateTime purchaseDate;

  /// 賞味期限
  final DateTime expirationDate;

  /// 購入価格
  /// >= 0
  final int price;

  /// 食べた？
  final bool ate;

  Stock({
    required this.id,
    required this.brandId,
    required this.purchaseDate,
    required this.expirationDate,
    required this.price,
    this.ate = false, //備蓄してすぐに食べるわけがない
  });
  Stock.self(Stock stock)
    : this(
        id: stock.id,
        brandId: stock.brandId,
        purchaseDate: stock.purchaseDate,
        expirationDate: stock.expirationDate,
        price: stock.price,
        ate: stock.ate,
      );

  /* From:To */
  factory Stock.fromMap(Map<String, Object?> map) => Stock(
    id: map[StockTableMap.id.name] as int,
    brandId: map[StockTableMap.brandId.name] as int,
    purchaseDate: DateTime.parse(
      map[StockTableMap.purchaseDate.name] as String,
    ),
    expirationDate: DateTime.parse(
      map[StockTableMap.expirationDate.name] as String,
    ),
    price: map[StockTableMap.price.name] as int,
    ate: map[StockTableMap.ate.name] as int > 0,
  );

  @override
  Map<String, Object?> toMap({bool isDB = false}) {
    if (brandId < 0) {
      throw RangeError.value(
        brandId,
        StockTableMap.brandId.name,
        '${StockTableMap.brandId.name} >= 0',
      );
    }
    if (price < 0) {
      throw RangeError.value(
        price,
        StockTableMap.price.name,
        '${StockTableMap.price.name} >= 0',
      );
    }
    return {
      // INTEGER(int)PrimaryKey
      StockTableMap.id.name: id >= 0 ? id : null,
      // INTEGER(int)
      StockTableMap.brandId.name: brandId,
      // TEXT | DateTime
      StockTableMap.purchaseDate.name: isDB
          ? purchaseDate.toString()
          : purchaseDate,
      // TEXT | DateTime
      StockTableMap.expirationDate.name: isDB
          ? expirationDate.toString()
          : expirationDate,
      // INTEGER(int)
      StockTableMap.price.name: price,
      // INTEGER | bool
      StockTableMap.ate.name: isDB ? (ate ? 1 : 0) : ate,
    };
  }

  static List<String> get tableDefinition => [
    StockTableMap.id.name.integer.primary,
    StockTableMap.brandId.name.integer.notnull,
    StockTableMap.purchaseDate.name.text.notnull,
    StockTableMap.expirationDate.name.text.notnull,
    StockTableMap.price.name.integer.notnull,
    StockTableMap.ate.name.integer.notnull,
  ];
}

enum StockTableMap { id, brandId, purchaseDate, expirationDate, price, ate }
