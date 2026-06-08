import 'base/i_mapperble.dart';
import 'ramyeon.dart';

class Rating implements IMapperble {
  /// [Rating] id
  final int id;

  /// [Ramyeon] id
  final int brandId;

  /// 評価（1-10）
  final int rating;

  /// 評価日
  final DateTime date;

  Rating({
    required this.id,
    required this.brandId,
    required this.rating,
    required this.date,
  });

  @override
  Map<String, Object?> toMap({bool isDB = false}) {
    if (brandId < 0) {
      throw RangeError.value(brandId, 'brandId', 'brandId >= 0');
    }
    if (rating < 1 || 10 < rating) {
      throw RangeError.value(rating, 'rating', '1 <= rating <= 10');
    }
    return {
      // INTEGER(int)PrimaryKey
      'id': id >= 0 ? id : null,
      // INTEGER(int)
      'brandId': brandId,
      // INTEGER(int)
      'rating': rating,
      // TEXT | DateTime
      'date': isDB ? date.toString() : date,
    };
  }

  @override
  String toString() =>
      'Rating{'
      'id: $id, '
      'brandId: $brandId, '
      'rating: $rating, '
      'date: $date'
      '}';

  static List<String> get tableDefinition => [
    'id INTEGER PRIMARY KEY',
    'brandId INTEGER not null',
    'rating INTEGER not null',
    'date TEXT not null',
  ];
}
