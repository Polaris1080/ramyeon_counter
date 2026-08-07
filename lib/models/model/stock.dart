// Base
import '../base/annnotation.dart';
import '../base/model_base.dart';
import '../base/table_difinition.dart';
// Model
import 'ramyeon.dart';
// Package
import 'package:darq/darq.dart';

/// 在庫（情報）
class Stock extends ModelBase {
  Stock({
    required this.id,
    required this.brandId,
    required this.purchaseDate,
    required this.expirationDate,
    required this.price,
    this.ate = false, //備蓄してすぐに食べるわけがない
  });

  /* Table */
  @PrimaryKey()
  final int id;
  Object? get _idValue => id >= 0 ? id : null;

  @OtherPrimary(Ramyeon)
  final int brandId;
  Object? get _brandIdValue => brandId;

  /// 購入日
  final DateTime purchaseDate;
  Object? _purchaseDateValue(bool isDB) =>
      isDB ? purchaseDate.toString() : purchaseDate;

  /// 賞味期限
  final DateTime expirationDate;
  Object? _expirationDateValue(bool isDB) =>
      isDB ? expirationDate.toString() : expirationDate;

  /// 購入価格
  @Constraint('>= 0')
  final int price;
  Object? get _priceValue => price;

  /// 食べた？
  final bool ate;
  Object? _ateValue(bool isDB) => isDB ? (ate ? 1 : 0) : ate;

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
    validate();
    return StockTableRow.values
        .select((s, _) => s.name)
        .zip(<Object?>[
          _idValue,
          _brandIdValue,
          _purchaseDateValue(isDB),
          _expirationDateValue(isDB),
          _priceValue,
          _ateValue(isDB),
        ], (key, value) => MapEntry(key, value))
        .toMap((m) => m);
  }

  @override
  String? validate() {
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
    return null;
  }

  static List<ColumuConstraint> get tableDefinition => [
    StockTableRow.id.integer.primary,
    StockTableRow.brandId.integer.notnull,
    StockTableRow.purchaseDate.text.notnull,
    StockTableRow.expirationDate.text.notnull,
    StockTableRow.price.integer.notnull,
    StockTableRow.ate.integer.notnull,
  ];
}

enum StockTableRow {
  /// INTEGER(int) PrimaryKey
  id,

  /// INTEGER(int)
  brandId,

  /// TEXT | DateTime
  purchaseDate,

  /// TEXT | DateTime
  expirationDate,

  /// INTEGER(int)
  price,

  /// INTEGER | bool
  ate,
}
