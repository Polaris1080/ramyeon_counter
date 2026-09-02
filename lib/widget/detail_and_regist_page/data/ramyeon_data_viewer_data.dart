part of 'ramyeon_data_viewer.dart';

class RamyeonDataViewerData({
  final String brand = "",
  final double rate = 0.0,
  final double? _price,
  final DateTime? _date,
}) {
  ///
  @OneTime()
  String get price => '価格：${_price is double ? _price.round() : " - "}円';

  ///
  @OneTime()
  String get date => (_price != null && _date is DateTime)
      ? '(${DateTime(_date.year - 1, _date.month, _date.day).format} - ${_date.format})'
      : "";
}

extension on DateTime {
  String get format => DateFormat('yyyy/MM/dd').format(this);
}
