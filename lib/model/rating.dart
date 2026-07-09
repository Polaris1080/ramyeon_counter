// Base
import 'base/model_base.dart';
import 'base/em_table_definition.dart';
// Model
import 'ramyeon.dart';

class Rating extends ModelBase {
  /// [Rating] id
  /// PrimaryKey (>= 0)
  final int id;

  /// [Ramyeon] id
  /// >= 0 (PrimaryKey)
  final int brandId;

  /// 評価
  /// 1 ~ 10
  final int rating;

  /// 評価日
  final DateTime date;

  Rating({
    required this.id,
    required this.brandId,
    required this.rating,
    required this.date,
  });

  /* From:To */
  factory Rating.fromMap(Map<String, Object?> map) => Rating(
    id: map[RatingTableRow.id.name] as int,
    brandId: map[RatingTableRow.brandId.name] as int,
    rating: map[RatingTableRow.rating.name] as int,
    date: DateTime.parse(map[RatingTableRow.date.name] as String),
  );

  @override
  Map<String, Object?> toMap({bool isDB = false}) {
    if (brandId < 0) {
      throw RangeError.value(
        brandId,
        RatingTableRow.brandId.name,
        '${RatingTableRow.brandId.name} >= 0',
      );
    }
    if (rating < 1 || 10 < rating) {
      throw RangeError.value(
        rating,
        RatingTableRow.rating.name,
        '1 <= ${RatingTableRow.rating.name} <= 10',
      );
    }
    return {
      // INTEGER(int)PrimaryKey
      RatingTableRow.id.name: id >= 0 ? id : null,
      // INTEGER(int)
      RatingTableRow.brandId.name: brandId,
      // INTEGER(int)
      RatingTableRow.rating.name: rating,
      // TEXT | DateTime
      RatingTableRow.date.name: isDB ? date.toString() : date,
    };
  }

  static List<String> get tableDefinition => [
    RatingTableRow.id.name.integer.primary,
    RatingTableRow.brandId.name.integer.notnull,
    RatingTableRow.rating.name.integer.notnull,
    RatingTableRow.date.name.text.notnull,
  ];
}

enum RatingTableRow { id, brandId, rating, date }
