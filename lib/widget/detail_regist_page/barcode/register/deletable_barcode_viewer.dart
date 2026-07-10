part of 'barcode_register.dart';

class DeletableBarcodeViewer extends StatelessWidget {
  static const _horizontalSpacing = 10.0, _verticalSpacing = 10.0;

  const DeletableBarcodeViewer(this.vm, {super.key});

  final BarcodeRegisterViewModel vm;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: vm,
      builder: (context, _) => Wrap(
        spacing: _horizontalSpacing,
        runSpacing: _verticalSpacing,
        children: vm.source.entries
            .select(
              (barcode, _) => DeletableChip(
                '${barcode.key}個：${barcode.value}',
                onDeleted: () => vm.remove(barcode.key),
              ),
            )
            .toList(),
      ),
    );
  }
}
