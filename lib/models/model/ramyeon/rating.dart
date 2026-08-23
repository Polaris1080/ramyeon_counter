// Base
import '../../base/column_behind.dart';
import '../base/em_castable_query_map.dart';
import '../../base/model_base.dart';

// Table
import '../../database/ramyeon/table/rating_table_columns.dart';

// Model
import 'ramyeon.dart';

class Rating({
  required int id,
  required int brandId,
  required int rating,
  required DateTime date,
}) extends ModelBase {
  /* Table */
  /// Primary
  int get id => _id.value;

  /// [Ramyeon]
  int get brandId => _brandId.value;

  /// 評価
  int get rating => _rating.value;

  /// 評価日
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

  /* Behind */
  final PrimaryColumnBehind _id = .new(id, RatingTableColumns.id);
  final OtherPrimaryColumnBehind _brandId = .new(
    brandId,
    RatingTableColumns.brandId,
  );
  final ColumnBehind<int> _rating = .rangeValidate(
    value: rating,
    column: RatingTableColumns.rating,
    to: (isDB) => rating,
    validator: () => rating < 1 || 10 < rating,
    supplement: '<= 10',
  );
  final NoValidateColumnBehind<DateTime> _date = .new(
    date,
    RatingTableColumns.date,
    to: (bool isDB) => isDB ? date.toString() : date,
  );
}
