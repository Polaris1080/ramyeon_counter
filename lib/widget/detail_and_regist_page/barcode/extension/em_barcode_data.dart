// Extention-type
import 'count.dart';
import 'jam.dart';

extension EmBarcodeData on MapEntry<Count, Jam> {
  /* Setting */
  static const _unit = '個';
  /* Method */
  Count get count => key;
  Jam get jam => value;
  String get displayData => '$key$_unit：$value';
}
