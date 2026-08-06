// Base
import '../base/model_base.dart';
import '../base/em_table_definition.dart';
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
    id: map[StockTableRow.id.name] as int,
    brandId: map[StockTableRow.brandId.name] as int,
    purchaseDate: DateTime.parse(
      map[StockTableRow.purchaseDate.name] as String,
    ),
    expirationDate: DateTime.parse(
      map[StockTableRow.expirationDate.name] as String,
    ),
    price: map[StockTableRow.price.name] as int,
    ate: map[StockTableRow.ate.name] as int > 0,
  );

  @override
  Map<String, Object?> toMap({bool isDB = false}) {
    if (brandId < 0) {
      throw RangeError.value(
        brandId,
        StockTableRow.brandId.name,
        '${StockTableRow.brandId.name} >= 0',
      );
    }
    if (price < 0) {
      throw RangeError.value(
        price,
        StockTableRow.price.name,
        '${StockTableRow.price.name} >= 0',
      );
    }
    return {
      // INTEGER(int)PrimaryKey
      StockTableRow.id.name: id >= 0 ? id : null,
      // INTEGER(int)
      StockTableRow.brandId.name: brandId,
      // TEXT | DateTime
      StockTableRow.purchaseDate.name: isDB
          ? purchaseDate.toString()
          : purchaseDate,
      // TEXT | DateTime
      StockTableRow.expirationDate.name: isDB
          ? expirationDate.toString()
          : expirationDate,
      // INTEGER(int)
      StockTableRow.price.name: price,
      // INTEGER | bool
      StockTableRow.ate.name: isDB ? (ate ? 1 : 0) : ate,
    };
  }

  static List<String> get tableDefinition => [
    StockTableRow.id.name.integer.primary,
    StockTableRow.brandId.name.integer.notnull,
    StockTableRow.purchaseDate.name.text.notnull,
    StockTableRow.expirationDate.name.text.notnull,
    StockTableRow.price.name.integer.notnull,
    StockTableRow.ate.name.integer.notnull,
  ];
}

enum StockTableRow { id, brandId, purchaseDate, expirationDate, price, ate }
