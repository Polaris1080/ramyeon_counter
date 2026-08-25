part of 'deletable_barcode_chip.dart';

class DeletableBarcodeChipViewModel({
  required super.data,
  final Function()? _onDeleted,
}) extends BarcodeChipViewModel {
  /// Delete icon pressed.
  @OneTime()
  Function()? get onIconPressed => _onDeleted;

  ///
  @OneTime()
  Function()? get onBodyPressed => _onDeleted == null ? () {} : null;
}
