import 'base/model_base.dart';
import 'ramyeon.dart';
// Extension
import 'package:ramyeon_counter/utility/extension_methods/em_int.dart';

class Barcode extends ModelBase {
  /// [Barcode].id
  /// PrimaryKey (>= 0)
  final int id;

  /// [Ramyeon].id
  /// >= 0 (PrimaryKey)
  final int brandId;

  /// 個数
  /// >= 1
  final int count;

  /// バーコード
  /// 8桁・13桁
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

  static List<String> get tableDefinition => [
    'id INTEGER PRIMARY KEY',
    'brandId INTEGER not null',
    'count INTEGER not null',
    'jam INTEGER not null',
  ];
}
