// Extention-type
import 'count.dart';
import 'jam.dart';

extension EmBarcodeData on MapEntry<Count, Jam> {
  String get displayData => '$key個：$value';
}
