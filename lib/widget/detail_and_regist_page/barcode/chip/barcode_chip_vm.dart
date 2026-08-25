part of 'barcode_chip.dart';

class BarcodeChipViewModel({required super.data, final double _width = 140.0})
    extends ViewerChipBaseViewModel {
  /// Chip width.
  @OneTime()
  double get width => _width;
}
