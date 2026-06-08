import 'base/i_mapperble.dart';
import 'ramyeon.dart';

/// 在庫（情報）
class Stock implements IMapperble {
  /// [Stock].id
  final int id;

  /// [Ramyeon].id
  final int brandId;

  /// 購入日
  final DateTime purchaseDate;

  /// 賞味期限
  final DateTime expirationDate;

  /// 購入価格
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

  @override
  String toString() =>
      'Stock{'
      'id: $id, '
      'brandId: $brandId, '
      'purchaseDate: $purchaseDate, '
      'expirationDate: $expirationDate, '
      'price: $price, '
      'ate: $ate'
      '}';

  static List<String> get tableDefinition => [
    'id INTEGER PRIMARY KEY',
    'brandId INTEGER not null',
    'purchaseDate TEXT not null',
    'expirationDate TEXT not null',
    'price INTEGER not null',
    'ate INTEGER not null',
  ];
}
