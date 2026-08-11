import '../table_column_difinition.dart';

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
