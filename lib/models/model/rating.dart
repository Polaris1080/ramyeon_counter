// Base
import '../base/annnotation.dart';
import '../base/column_difinition.dart';
import '../base/em_castable_query_map.dart';
import '../base/model_base.dart';
import '../base/table_difinition.dart';
// Model
import 'ramyeon.dart';

class Rating extends ModelBase {
  Rating({
    required int id,
    required int brandId,
    required int rating,
    required DateTime date,
  }) : _id = .new(
         value: id,
         column: RatingTableRow.id,
         to: (bool isDB) => id >= 0 ? id : null,
       ),
       _brandId = .new(
         value: brandId,
         column: RatingTableRow.brandId,
         to: (bool isDB) => brandId,
         validator: () => brandId < 0,
         error: RangeError.value(
           brandId,
           RatingTableRow.brandId.name,
           '${RatingTableRow.brandId.name} >= 0',
         ),
       ),
       _rating = .new(
         value: rating,
         column: RatingTableRow.rating,
         to: (isDB) => rating,
         validator: () => rating < 1 || 10 < rating,
         error: RangeError.value(
           rating,
           RatingTableRow.rating.name,
           '1 <= ${RatingTableRow.rating.name} <= 10',
         ),
       ),
       _date = .new(
         value: date,
         column: RatingTableRow.date,
         to: (bool isDB) => isDB ? date.toString() : date,
       );

  /* Table */
  @PrimaryKey()
  final ColumnDifinition<int> _id;
  int get id => _id.value;

  @OtherPrimary(Ramyeon)
  final ColumnDifinition<int> _brandId;
  int get brandId => _brandId.value;

  /// 評価
  @Constraint('1 ~ 10')
  final ColumnDifinition<int> _rating;
  int get rating => _rating.value;

  /// 評価日
  final ColumnDifinition<DateTime> _date;
  DateTime get date => _date.value;

  /* From:To */
  factory Rating.fromMap(Map<String, Object?> map) => Rating(
    id: RatingTableRow.id.cast<int>(map),
    brandId: RatingTableRow.brandId.cast<int>(map),
    rating: RatingTableRow.rating.cast<int>(map),
    date: RatingTableRow.date.castDateTime(map),
  );

  @override
  List<ColumnDifinition<Object>> get columus => [_id, _brandId, _rating, _date];

  static List<ColumuConstraint> get tableDefinition => [
    RatingTableRow.id.integer.primary,
    RatingTableRow.brandId.integer.notnull,
    RatingTableRow.rating.integer.notnull,
    RatingTableRow.date.text.notnull,
  ];
}

enum RatingTableRow {
  /// INTEGER(int) PrimaryKey
  id,

  /// INTEGER(int)
  brandId,

  /// INTEGER(int)
  rating,

  /// TEXT | DateTime
  date,
}
