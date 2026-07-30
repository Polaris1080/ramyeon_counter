part of 'barcode_register.dart';

class QuantitySelector extends StatelessWidget {
  static const _countStart = 1,
      _countLegnth = 5,
      _fullLengthCode = 65248,
      _tooltip = '個数',
      _unit = '個';

  const QuantitySelector(this.vm, {super.key});

  final BarcodeRegisterViewModel vm;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: vm,
      builder: (context, _) => SegmentedButton<int>(
        onSelectionChanged: vm.countChanged,
        selected: {vm.countSelected},
        showSelectedIcon: false,
        segments: RangeIterable(_countStart, _countStart + _countLegnth)
            .select(
              (i, _) => ButtonSegment<int>(
                value: i,
                // 選択されている
                label: Text(
                  i == vm.countSelected
                      ? '${_fullWidthDigits(i.toString())}$_unit'
                      : '$i',
                ),
                // その個数で登録されていない＆選択されていない
                tooltip: !vm.source.containsKey(i) && i != vm.countSelected
                    ? _tooltip
                    : null,
                // その個数で登録されていない
                enabled: !vm.source.containsKey(i),
              ),
            )
            .toList(),
      ),
    );
  }

  String _fullWidthDigits(String char) =>
      String.fromCharCode(char.codeUnitAt(0) + _fullLengthCode);
}
