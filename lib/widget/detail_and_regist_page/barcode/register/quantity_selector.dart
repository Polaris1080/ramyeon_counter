part of '../barcode_register.dart';

class const QuantitySelector(
  @protected final BarcodeRegisterViewModel vm, {
  super.key,
}) extends StatelessWidget {
  static const _count = 5, _tooltip = '個数', _unit = '個';

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: vm,
      builder: (context, _) => SegmentedButton<int>(
        onSelectionChanged: vm.countChanged,
        selected: {vm.countSelected.value},
        showSelectedIcon: false,
        segments: _count.toRangeIterable().map((i) {
          return switch ((vm.countSelected == i, vm.source.containsKey(i))) {
            // 選択されており、その個数で登録されている
            (true, true) => ButtonSegment<int>(
              value: i,
              label: Text('${i.fullWidthDigits}$_unit'),
              tooltip: null,
              enabled: false,
            ),
            // 選択されており、その個数で登録されていない
            (true, false) => ButtonSegment<int>(
              value: i,
              label: Text('${i.fullWidthDigits}$_unit'),
              tooltip: null,
              enabled: true,
            ),
            // 選択されていないが、その個数で登録されている
            (false, true) => ButtonSegment<int>(
              value: i,
              label: Text('$i'),
              tooltip: null,
              enabled: false,
            ),
            // 選択されていないが、その個数で登録されていない
            (false, false) => ButtonSegment<int>(
              value: i,
              label: Text('$i'),
              tooltip: _tooltip,
              enabled: true,
            ),
          };
        }).toList(),
      ),
    );
  }
}

/* extension(self) */
extension on int {
  /* Method */
  String get fullWidthDigits => toString().fullWidthDigits;
  RangeIterable toRangeIterable({int start = 1}) {
    assert(this >= 1);
    return .new(start, start + this);
  }
}

extension on String {
  /* Setting */
  static const _fullLengthCode = 65248;
  /* Method */
  String get fullWidthDigits => length
      .toRangeIterable()
      .select((_, i) => String.fromCharCode(codeUnitAt(i) + _fullLengthCode))
      .join();
}
