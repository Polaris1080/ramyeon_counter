// Extention-type
import 'count.dart';
import 'jam.dart';

extension EmBarcodeData on MapEntry<Count, Jam> {
  int get count => key.value;
  int get jam => value.value;
  String get displayData => '$key個：$value';
}
