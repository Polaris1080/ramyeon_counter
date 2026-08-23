// Base
import '../base/column_behind.dart';
import '../base/em_castable_query_map.dart';
import '../base/model_base.dart';
// Table
import '../database/ramyeon/table/rating_table_columns.dart';
// Model
import 'ramyeon.dart';

class Rating extends ModelBase {
  Rating({
    required int id,
    required int brandId,
    required int rating,
    required DateTime date,
  }) : _id = .new(id, RatingTableColumns.id),
       _brandId = .new(brandId, RatingTableColumns.brandId),
       _rating = .rangeValidate(
         value: rating,
         column: RatingTableColumns.rating,
         to: (isDB) => rating,
         validator: () => rating < 1 || 10 < rating,
         supplement: '<= 10',
       ),
       _date = .new(
         date,
         RatingTableColumns.date,
         to: (bool isDB) => isDB ? date.toString() : date,
       );

  /* Table */
  /// Primary
  final PrimaryColumnBehind _id;
  int get id => _id.value;

  /// [Ramyeon]
  final OtherPrimaryColumnBehind _brandId;
  int get brandId => _brandId.value;

  /// 評価
  final ColumnBehind<int> _rating;
  int get rating => _rating.value;

  /// 評価日
  final NoValidateColumnBehind<DateTime> _date;
  DateTime get date => _date.value;

  /* From:To */
  factory Rating.fromMap(Map<String, Object?> map) => Rating(
    id: RatingTableColumns.id.cast<int>(map),
    brandId: RatingTableColumns.brandId.cast<int>(map),
    rating: RatingTableColumns.rating.cast<int>(map),
    date: RatingTableColumns.date.castDateTime(map),
  );

  @override
  List<ColumnBehind<Object>> get columus => [_id, _brandId, _rating, _date];
}
