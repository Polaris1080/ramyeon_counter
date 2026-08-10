// Base
import '../base/annnotation.dart';
import '../base/column_difinition.dart';
import '../base/em_castable_query_map.dart';
import '../base/model_base.dart';
import '../base/table_difinition.dart';
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
         column: StockTableRow.id,
         to: (bool isDB) => id >= 0 ? id : null,
       ),
       _brandId = .new(
         value: brandId,
         column: StockTableRow.brandId,
         to: (bool isDB) => brandId,
         validator: () => brandId < 0,
         error: RangeError.value(
           brandId,
           StockTableRow.brandId.name,
           '${StockTableRow.brandId.name} >= 0',
         ),
       ),
       _purchaseDate = .new(
         value: purchaseDate,
         column: StockTableRow.purchaseDate,
         to: (bool isDB) => isDB ? purchaseDate.toString() : purchaseDate,
       ),
       _expirationDate = .new(
         value: expirationDate,
         column: StockTableRow.expirationDate,
         to: (bool isDB) => isDB ? expirationDate.toString() : expirationDate,
       ),
       _price = .new(
         value: price,
         column: StockTableRow.price,
         to: (bool isDB) => price,
         validator: () => price < 0,
         error: RangeError.value(
           price,
           StockTableRow.price.name,
           '${StockTableRow.price.name} >= 0',
         ),
       ),
       _ate = .new(
         value: ate,
         column: StockTableRow.ate,
         to: (bool isDB) => isDB ? (ate ? 1 : 0) : ate,
       );

  /* Table */
  @PrimaryKey()
  final ColumnDifinition<int> _id;
  int get id => _id.value;

  @OtherPrimary(Ramyeon)
  final ColumnDifinition<int> _brandId;
  int get brandId => _brandId.value;

  /// 購入日
  final ColumnDifinition<DateTime> _purchaseDate;
  DateTime get purchaseDate => _purchaseDate.value;

  /// 賞味期限
  final ColumnDifinition<DateTime> _expirationDate;
  DateTime get expirationDate => _expirationDate.value;

  /// 購入価格
  @Constraint('>= 0')
  final ColumnDifinition<int> _price;
  int get price => _price.value;

  /// 食べた？
  final ColumnDifinition<bool> _ate;
  bool get ate => _ate.value;

  /* From:To */
  factory Stock.fromMap(Map<String, Object?> map) => Stock(
    id: StockTableRow.id.cast<int>(map),
    brandId: StockTableRow.brandId.cast<int>(map),
    purchaseDate: StockTableRow.purchaseDate.castDateTime(map),
    expirationDate: StockTableRow.expirationDate.castDateTime(map),
    price: StockTableRow.price.cast<int>(map),
    ate: StockTableRow.ate.castBool(map),
  );

  @override
  List<ColumnDifinition<Object>> get columus => [
    _id,
    _brandId,
    _purchaseDate,
    _expirationDate,
    _price,
    _ate,
  ];

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
