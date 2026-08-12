// Base
import '../base/column_behind.dart';
import '../base/em_castable_query_map.dart';
import '../base/model_base.dart';
// Table
import '../table/ramyeon/barcode_table_columns.dart';
// Extension
import 'package:ramyeon_counter/utility/extension_methods/em_int.dart';
// Model
import 'ramyeon.dart';

class Barcode extends ModelBase {
  Barcode({
    required int id,
    required int brandId,
    required int count,
    required int jam,
  }) : _id = .new(id, BarcodeTableColumns.id),
       _brandId = OtherPrimaryColumnBehind(
         brandId,
         BarcodeTableColumns.brandId,
       ),
       _count = .rangeValidate(
         value: count,
         column: BarcodeTableColumns.count,
         validator: () => count < 1,
         supplement: '>= 1',
       ),
       _jam = .rangeValidate(
         value: jam,
         column: BarcodeTableColumns.jam,
         validator: () => !(jam.digit == 8 || jam.digit == 13),
         supplement: 'digit is 8 or 13.',
       );

  /* Table */
  /// Primary
  final PrimaryColumnBehind _id;
  int get id => _id.value;

  /// [Ramyeon]
  final ColumnBehind<int> _brandId;
  int get brandId => _brandId.value;

  /// 個数
  final ColumnBehind<int> _count;
  int get count => _count.value;

  /// バーコード
  final ColumnBehind<int> _jam;
  int get jam => _jam.value;

  /* From:To */
  factory Barcode.fromMap(Map<String, Object?> map) => Barcode(
    id: BarcodeTableColumns.id.cast<int>(map),
    brandId: BarcodeTableColumns.brandId.cast<int>(map),
    count: BarcodeTableColumns.count.cast<int>(map),
    jam: BarcodeTableColumns.jam.cast<int>(map),
  );

  @override
  List<ColumnBehind<Object>> get columus => [_id, _brandId, _count, _jam];
}
