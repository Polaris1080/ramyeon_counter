// Base
import 'model_annnotations.dart';
import '../base/column_difinition.dart';
import '../base/em_castable_query_map.dart';
import '../base/model_base.dart';
// Table
import '../table/ramyeon/rating_table_columns.dart';
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
         column: RatingTableColumns.id,
         to: (bool isDB) => id >= 0 ? id : null,
       ),
       _brandId = .new(
         value: brandId,
         column: RatingTableColumns.brandId,
         to: (bool isDB) => brandId,
         validator: () => brandId < 0,
         error: RangeError.value(
           brandId,
           RatingTableColumns.brandId.name,
           '${RatingTableColumns.brandId.name} >= 0',
         ),
       ),
       _rating = .new(
         value: rating,
         column: RatingTableColumns.rating,
         to: (isDB) => rating,
         validator: () => rating < 1 || 10 < rating,
         error: RangeError.value(
           rating,
           RatingTableColumns.rating.name,
           '1 <= ${RatingTableColumns.rating.name} <= 10',
         ),
       ),
       _date = .new(
         value: date,
         column: RatingTableColumns.date,
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
    id: RatingTableColumns.id.cast<int>(map),
    brandId: RatingTableColumns.brandId.cast<int>(map),
    rating: RatingTableColumns.rating.cast<int>(map),
    date: RatingTableColumns.date.castDateTime(map),
  );

  @override
  List<ColumnDifinition<Object>> get columus => [_id, _brandId, _rating, _date];
}
