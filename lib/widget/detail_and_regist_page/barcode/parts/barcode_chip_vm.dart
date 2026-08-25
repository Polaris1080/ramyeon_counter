part of 'barcode_chip.dart';

class BarcodeChipViewModel({
  required final String _data,
  final double _width = 140.0,
}) extends ChangeNotifier {
  /// Chip text.
  @OneTime()
  String get data => _data;

  /// Chip width.
  @OneTime()
  double get width => _width;
}
