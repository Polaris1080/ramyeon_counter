// Base
import '../base/model_annnotations.dart';
import '../base/column_behind.dart';
import '../base/em_castable_query_map.dart';
import '../base/model_base.dart';
// Table
import '../table/ramyeon/stock_table_columns.dart';
// Model
import 'ramyeon.dart';

/// 在庫（情報）
class Stock extends ModelBase {
  Stock({
    required int id,
    required int brandId,
    required DateTime purchaseDate,
    required DateTime expirationDate,
    required int price,
    bool ate = false, //備蓄してすぐに食べるわけがない
  }) : _id = .new(
         value: id,
         column: StockTableColumns.id,
         to: (bool isDB) => id >= 0 ? id : null,
       ),
       _brandId = .new(
         value: brandId,
         column: StockTableColumns.brandId,
         to: (bool isDB) => brandId,
         validator: () => brandId < 0,
         error: RangeError.value(
           brandId,
           StockTableColumns.brandId.name,
           '${StockTableColumns.brandId.name} >= 0',
         ),
       ),
       _purchaseDate = .new(
         value: purchaseDate,
         column: StockTableColumns.purchaseDate,
         to: (bool isDB) => isDB ? purchaseDate.toString() : purchaseDate,
       ),
       _expirationDate = .new(
         value: expirationDate,
         column: StockTableColumns.expirationDate,
         to: (bool isDB) => isDB ? expirationDate.toString() : expirationDate,
       ),
       _price = .new(
         value: price,
         column: StockTableColumns.price,
         to: (bool isDB) => price,
         validator: () => price < 0,
         error: RangeError.value(
           price,
           StockTableColumns.price.name,
           '${StockTableColumns.price.name} >= 0',
         ),
       ),
       _ate = .new(
         value: ate,
         column: StockTableColumns.ate,
         to: (bool isDB) => isDB ? (ate ? 1 : 0) : ate,
       );

  /* Table */
  @PrimaryKey()
  final ColumnBehind<int> _id;
  int get id => _id.value;

  @OtherPrimary(Ramyeon)
  final ColumnBehind<int> _brandId;
  int get brandId => _brandId.value;

  /// 購入日
  final ColumnBehind<DateTime> _purchaseDate;
  DateTime get purchaseDate => _purchaseDate.value;

  /// 賞味期限
  final ColumnBehind<DateTime> _expirationDate;
  DateTime get expirationDate => _expirationDate.value;

  /// 購入価格
  @Constraint('>= 0')
  final ColumnBehind<int> _price;
  int get price => _price.value;

  /// 食べた？
  final ColumnBehind<bool> _ate;
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
}
