// Base
import '../base/annnotation.dart';
import '../base/column_difinition.dart';
import '../base/model_base.dart';
import '../base/table_difinition.dart';
// Model
import 'ramyeon.dart';
// Extension
import 'package:ramyeon_counter/utility/extension_methods/em_int.dart';

class Barcode extends ModelBase {
  Barcode({
    required int id,
    required int brandId,
    required int count,
    required int jam,
  }) : _id = .new(
         value: id,
         column: BarcodeTableRow.id,
         to: (bool isDB) => id >= 0 ? id : null,
       ),
       _brandId = .new(
         value: brandId,
         column: BarcodeTableRow.brandId,
         to: (bool isDB) => brandId,
         validator: () => brandId < 0,
         error: RangeError.value(
           brandId,
           BarcodeTableRow.brandId.name,
           '${BarcodeTableRow.brandId.name} >= 0',
         ),
       ),
       _count = .new(
         value: count,
         column: BarcodeTableRow.count,
         to: (bool? isDB) => count,
         validator: () => count < 1,
         error: RangeError.value(
           count,
           BarcodeTableRow.count.name,
           '${BarcodeTableRow.count.name} >= 1',
         ),
       ),
       _jam = .new(
         value: jam,
         column: BarcodeTableRow.jam,
         to: (bool? isDB) => jam,
         validator: () => !(jam.digit == 8 || jam.digit == 13),
         error: RangeError.value(
           jam,
           BarcodeTableRow.jam.name,
           '${BarcodeTableRow.jam.name} digit is 8 or 13.',
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
    id: map[BarcodeTableRow.id.name] as int,
    brandId: map[BarcodeTableRow.brandId.name] as int,
    count: map[BarcodeTableRow.count.name] as int,
    jam: map[BarcodeTableRow.jam.name] as int,
  );

  @override
  List<ColumnDifinition<Object>> get columus => [_id, _brandId, _count, _jam];

  static List<ColumuConstraint> get tableDefinition => [
    BarcodeTableRow.id.integer.primary,
    BarcodeTableRow.brandId.integer.notnull,
    BarcodeTableRow.count.integer.notnull,
    BarcodeTableRow.jam.integer.notnull,
  ];
}

enum BarcodeTableRow {
  /// INTEGER(int) PrimaryKey
  id,

  /// INTEGER(int) OtherPrimary
  brandId,

  /// INTEGER(int) >=1
  count,

  /// INTEGER(int) digit=8|13
  jam,
}
