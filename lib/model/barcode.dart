import 'base/i_mapperble.dart';
import 'ramyeon.dart';
import 'package:ramyeon_counter/utility/extension_methods/em_int.dart';

class Barcode implements IMapperble {
  /// [Barcode].id
  final int id;

  /// [Ramyeon].id
  final int brandId;

  /// 個数
  final int count;

  /// バーコード
  final int jam;

  Barcode({
    required this.id,
    required this.brandId,
    required this.count,
    required this.jam,
  });

  @override
  Map<String, Object?> toMap({bool isDB = false}) {
    if (brandId < 0) {
      throw RangeError.value(brandId, 'brandId', 'brandId >= 0');
    }
    if (count < 1) {
      throw RangeError.value(count, 'count', 'count >= 1');
    }
    if (!(jam.digit == 8 || jam.digit == 13)) {
      throw RangeError.value(jam, 'jam', 'jam digit is 8 or 13.');
    }
    return {
      // INTEGER(int) PrimaryKey
      'id': id >= 0 ? id : null,
      // INTEGER(int) >=0
      'brandId': brandId,
      // INTEGER(int) >=1
      'count': count,
      // INTEGER(int) digit=8|13
      'jam': jam,
    };
  }

  @override
  String toString() =>
      'Ramyeon{'
      'id: $id, '
      'brandId: $brandId, '
      'count: $count, '
      'jam: $jam'
      '}';

  static List<String> get tableDefinition => [
    'id INTEGER PRIMARY KEY',
    'brandId INTEGER not null',
    'count INTEGER not null',
    'jam INTEGER not null',
  ];
}
