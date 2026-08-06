// Base
import '../base/annnotation.dart';
import '../base/model_base.dart';
import '../base/em_table_definition.dart';
// Model
import 'ramyeon.dart';
// Package
import 'package:darq/darq.dart';

class Rating extends ModelBase {
  Rating({
    required this.id,
    required this.brandId,
    required this.rating,
    required this.date,
  });

  /* Table */
  @PrimaryKey()
  final int id;

  @OtherPrimary(Ramyeon)
  final int brandId;

  /// 評価
  @Constraint('1 ~ 10')
  final int rating;

  /// 評価日
  final DateTime date;

  /* From:To */
  factory Rating.fromMap(Map<String, Object?> map) => Rating(
    id: map[RatingTableRow.id.name] as int,
    brandId: map[RatingTableRow.brandId.name] as int,
    rating: map[RatingTableRow.rating.name] as int,
    date: DateTime.parse(map[RatingTableRow.date.name] as String),
  );

  @override
  Map<String, Object?> toMap({bool isDB = false}) {
    validate();
    return RatingTableRow.values
        .select((s, _) => s.name)
        .zip(<Object?>[
          id >= 0 ? id : null,
          brandId,
          rating,
          isDB ? date.toString() : date,
        ], (key, value) => MapEntry(key, value))
        .toMap((m) => m);
  }

  @override
  String? validate() {
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
    return null;
  }

  static List<String> get tableDefinition => [
    RatingTableRow.id.name.integer.primary,
    RatingTableRow.brandId.name.integer.notnull,
    RatingTableRow.rating.name.integer.notnull,
    RatingTableRow.date.name.text.notnull,
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
