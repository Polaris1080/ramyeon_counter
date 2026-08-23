import '../../table_columns_base.dart';

enum RatingTableColumns {
  id,
  brandId,
  rating,
  date;

  static List<ColumnConstraint> get tableDefinition => [
    RatingTableColumns.id.integer.primary,
    RatingTableColumns.brandId.integer.notnull,
    RatingTableColumns.rating.integer.notnull,
    RatingTableColumns.date.text.notnull, // DateTime
  ];
}
