// Base
import '../base/annnotation.dart';
import '../base/model_base.dart';
import '../base/table_difinition.dart';
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
  Object? get _idValue => id >= 0 ? id : null;

  @OtherPrimary(Ramyeon)
  final int brandId;
  Object? get _brandIdValue => brandId;

  /// 評価
  @Constraint('1 ~ 10')
  final int rating;
  Object? get _ratingValue => rating;

  /// 評価日
  final DateTime date;
  Object? _dateValue(bool isDB) => isDB ? date.toString() : date;

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
          _idValue,
          _brandIdValue,
          _ratingValue,
          _dateValue(isDB),
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
