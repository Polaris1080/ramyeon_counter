// Base
import '../base/annnotation.dart';
import '../base/column_difinition.dart';
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
  }) : _id = .new(
         value: id,
         column: BarcodeTableColumns.id,
         to: (bool isDB) => id >= 0 ? id : null,
       ),
       _brandId = .new(
         value: brandId,
         column: BarcodeTableColumns.brandId,
         to: (bool isDB) => brandId,
         validator: () => brandId < 0,
         error: RangeError.value(
           brandId,
           BarcodeTableColumns.brandId.name,
           '${BarcodeTableColumns.brandId.name} >= 0',
         ),
       ),
       _count = .new(
         value: count,
         column: BarcodeTableColumns.count,
         to: (bool? isDB) => count,
         validator: () => count < 1,
         error: RangeError.value(
           count,
           BarcodeTableColumns.count.name,
           '${BarcodeTableColumns.count.name} >= 1',
         ),
       ),
       _jam = .new(
         value: jam,
         column: BarcodeTableColumns.jam,
         to: (bool? isDB) => jam,
         validator: () => !(jam.digit == 8 || jam.digit == 13),
         error: RangeError.value(
           jam,
           BarcodeTableColumns.jam.name,
           '${BarcodeTableColumns.jam.name} digit is 8 or 13.',
         ),
       );

  /* Table */
  @PrimaryKey()
  final ColumnDifinition<int> _id;
  int get id => _id.value;

  @OtherPrimary(Ramyeon)
  final ColumnDifinition<int> _brandId;
  int get brandId => _brandId.value;

  /// 個数
  @Constraint('>= 1')
  final ColumnDifinition<int> _count;
  int get count => _count.value;

  /// バーコード
  @Constraint('8/13桁')
  final ColumnDifinition<int> _jam;
  int get jam => _jam.value;

  /* From:To */
  factory Barcode.fromMap(Map<String, Object?> map) => Barcode(
    id: BarcodeTableColumns.id.cast<int>(map),
    brandId: BarcodeTableColumns.brandId.cast<int>(map),
    count: BarcodeTableColumns.count.cast<int>(map),
    jam: BarcodeTableColumns.jam.cast<int>(map),
  );

  @override
  List<ColumnDifinition<Object>> get columus => [_id, _brandId, _count, _jam];
}
