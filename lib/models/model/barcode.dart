// Base
import '../base/annnotation.dart';
import '../base/model_base.dart';
import '../base/em_table_definition.dart';
// Model
import 'ramyeon.dart';
// Extension
import 'package:ramyeon_counter/utility/extension_methods/em_int.dart';

class Barcode extends ModelBase {
  Barcode({
    required this.id,
    required this.brandId,
    required this.count,
    required this.jam,
  });

  /* Table */
  @PrimaryKey()
  final int id;

  @OtherPrimary(Ramyeon)
  final int brandId;

  /// 個数
  @Constraint('>= 1')
  final int count;

  /// バーコード
  @Constraint('8/13桁')
  final int jam;

  /* From:To */
  factory Barcode.fromMap(Map<String, Object?> map) => Barcode(
    id: map[BarcodeTableRow.id.name] as int,
    brandId: map[BarcodeTableRow.brandid.name] as int,
    count: map[BarcodeTableRow.count.name] as int,
    jam: map[BarcodeTableRow.jam.name] as int,
  );

  @override
  Map<String, Object?> toMap({bool isDB = false}) {
    validate();
    return {
      BarcodeTableRow.id.name: id >= 0 ? id : null,
      BarcodeTableRow.brandid.name: brandId,
      BarcodeTableRow.count.name: count,
      BarcodeTableRow.jam.name: jam,
    };
  }

  @override
  String? validate() {
    if (brandId < 0) {
      throw RangeError.value(
        brandId,
        BarcodeTableRow.brandid.name,
        '${BarcodeTableRow.brandid.name} >= 0',
      );
    }
    if (count < 1) {
      throw RangeError.value(
        count,
        BarcodeTableRow.count.name,
        '${BarcodeTableRow.count.name} >= 1',
      );
    }
    if (!(jam.digit == 8 || jam.digit == 13)) {
      throw RangeError.value(
        jam,
        BarcodeTableRow.jam.name,
        '${BarcodeTableRow.jam.name} digit is 8 or 13.',
      );
    }
    return null;
  }

  static List<String> get tableDefinition => [
    BarcodeTableRow.id.name.integer.primary,
    BarcodeTableRow.brandid.name.integer.notnull,
    BarcodeTableRow.count.name.integer.notnull,
    BarcodeTableRow.jam.name.integer.notnull,
  ];
}

enum BarcodeTableRow {
  /// INTEGER(int) PrimaryKey
  id,

  /// INTEGER(int) OtherPrimary
  brandid,

  /// INTEGER(int) >=1
  count,

  /// INTEGER(int) digit=8|13
  jam,
}
