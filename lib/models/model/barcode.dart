// Base
import '../base/annnotation.dart';
import '../base/model_base.dart';
import '../base/table_difinition.dart';
// Model
import 'ramyeon.dart';
// Package
import 'package:darq/darq.dart';
// Extension
import 'package:ramyeon_counter/utility/extension_methods/em_int.dart';

class Barcode extends ModelBase {
  Barcode({
    required this.id,
    required this.brandId,
    required this.count,
    required this.jam,
  });

  // TODO:Chain Of Responsibility パターン
  /* Table */
  @PrimaryKey()
  final int id;
  Object? get _idValue => id >= 0 ? id : null;
  static ColumuConstraint get _idColumuDefinition =>
      PrimaryConstraint(IntColumn());

  @OtherPrimary(Ramyeon)
  final int brandId;
  Object? get _brandIdValue => brandId;
  static ColumuConstraint get _brandIdColumuDefinition =>
      NotNullConstraint(IntColumn());
  void _brandIdValidator() {
    if (brandId < 0) {
      throw RangeError.value(
        brandId,
        BarcodeTableRow.brandId.name,
        '${BarcodeTableRow.brandId.name} >= 0',
      );
    }
  }

  /// 個数
  @Constraint('>= 1')
  final int count;
  Object? get _countValue => count;
  static ColumuConstraint get _countColumuDefinition =>
      NotNullConstraint(IntColumn());
  void _countValidator() {
    if (count < 1) {
      throw RangeError.value(
        count,
        BarcodeTableRow.count.name,
        '${BarcodeTableRow.count.name} >= 1',
      );
    }
  }

  /// バーコード
  @Constraint('8/13桁')
  final int jam;
  Object? get _jamValue => jam;
  static ColumuConstraint get _jamColumuDefinition =>
      NotNullConstraint(IntColumn());
  void _jamValidator() {
    throw RangeError.value(
      jam,
      BarcodeTableRow.jam.name,
      '${BarcodeTableRow.jam.name} digit is 8 or 13.',
    );
  }

  /* From:To */
  factory Barcode.fromMap(Map<String, Object?> map) => Barcode(
    id: map[BarcodeTableRow.id.name] as int,
    brandId: map[BarcodeTableRow.brandId.name] as int,
    count: map[BarcodeTableRow.count.name] as int,
    jam: map[BarcodeTableRow.jam.name] as int,
  );

  @override
  Map<String, Object?> toMap({bool isDB = false}) {
    validate();
    return BarcodeTableRow.values
        .select((s, _) => s.name)
        .zip(<Object?>[
          _idValue,
          _brandIdValue,
          _countValue,
          _jamValue,
        ], (key, value) => MapEntry(key, value))
        .toMap((m) => m);
  }

  @override
  String? validate() {
    _brandIdValidator();
    _countValidator();
    _jamValidator();
    return null;
  }

  static Map<String, ColumuConstraint> get tableDefinition => BarcodeTableRow
      .values
      .select((s, _) => s.name)
      .zip([
        _idColumuDefinition,
        _brandIdColumuDefinition,
        _countColumuDefinition,
        _jamColumuDefinition,
      ], (k, v) => MapEntry(k, v))
      .toMap((m) => m);
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
