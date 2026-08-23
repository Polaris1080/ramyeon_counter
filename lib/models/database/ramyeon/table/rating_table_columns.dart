// Base
import '../../base/column_definition.dart';
import '../../base/table_columns_base.dart';

enum RatingTableColumns implements TableColumnsBase{
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
