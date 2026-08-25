/// @docImport  'ramyeon.dart';
library;

// Base
import '../../base/column_behind.dart';
import '../base/em_castable_query_map.dart';
import '../../base/model_base.dart';

// Table
import '../../database/ramyeon/table/stock_table_columns.dart';

/// 在庫（情報）
class Stock({
  required int id,
  required int brandId,
  required DateTime purchaseDate,
  required DateTime expirationDate,
  required int price,
  bool ate = false, //備蓄してすぐに食べるわけがない
}) extends ModelBase {
  /* Table */
  /// Primary
  int get id => _id.value;

  /// [Ramyeon]
  int get brandId => _brandId.value;

  /// 購入日
  DateTime get purchaseDate => _purchaseDate.value;

  /// 賞味期限
  DateTime get expirationDate => _expirationDate.value;

  /// 購入価格
  int get price => _price.value;

  /// 食べた？
  bool get ate => _ate.value;

  /* From:To */
  factory Stock.fromMap(Map<String, Object?> map) => Stock(
    id: StockTableColumns.id.cast<int>(map),
    brandId: StockTableColumns.brandId.cast<int>(map),
    purchaseDate: StockTableColumns.purchaseDate.castDateTime(map),
    expirationDate: StockTableColumns.expirationDate.castDateTime(map),
    price: StockTableColumns.price.cast<int>(map),
    ate: StockTableColumns.ate.castBool(map),
  );

  @override
  List<ColumnBehind<Object>> get columus => [
    _id,
    _brandId,
    _purchaseDate,
    _expirationDate,
    _price,
    _ate,
  ];

  /* Behind */
  final PrimaryColumnBehind _id = .new(id, StockTableColumns.id);
  final OtherPrimaryColumnBehind _brandId = .new(
    brandId,
    StockTableColumns.brandId,
  );
  final NoValidateColumnBehind<DateTime> _purchaseDate = .new(
    purchaseDate,
    StockTableColumns.purchaseDate,
    to: (bool isDB) => isDB ? purchaseDate.toString() : purchaseDate,
  );
  final NoValidateColumnBehind<DateTime> _expirationDate = .new(
    expirationDate,
    StockTableColumns.expirationDate,
    to: (bool isDB) => isDB ? expirationDate.toString() : expirationDate,
  );
  final ColumnBehind<int> _price = .rangeValidate(
    value: price,
    column: StockTableColumns.price,
    validator: () => price < 0,
    supplement: '>= 0',
  );
  final NoValidateColumnBehind<bool> _ate = .new(
    ate,
    StockTableColumns.ate,
    to: (bool isDB) => isDB ? (ate ? 1 : 0) : ate,
  );
}
