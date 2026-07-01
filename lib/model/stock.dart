import 'base/model_base.dart';
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

  @override
  Map<String, Object?> toMap({bool isDB = false}) {
    if (brandId < 0) {
      throw RangeError.value(brandId, 'brandId', 'brandId >= 0');
    }
    if (price < 0) {
      throw RangeError.value(price, 'price', 'price >= 0');
    }
    return {
      // INTEGER(int)PrimaryKey
      'id': id >= 0 ? id : null,
      // INTEGER(int)
      'brandId': brandId,
      // TEXT | DateTime
      'purchaseDate': isDB ? purchaseDate.toString() : purchaseDate,
      // TEXT | DateTime
      'expirationDate': isDB ? expirationDate.toString() : expirationDate,
      // INTEGER(int)
      'price': price,
      // INTEGER | bool
      'ate': isDB ? (ate ? 1 : 0) : ate,
    };
  }

  static List<String> get tableDefinition => [
    'id INTEGER PRIMARY KEY',
    'brandId INTEGER not null',
    'purchaseDate TEXT not null',
    'expirationDate TEXT not null',
    'price INTEGER not null',
    'ate INTEGER not null',
  ];
}
