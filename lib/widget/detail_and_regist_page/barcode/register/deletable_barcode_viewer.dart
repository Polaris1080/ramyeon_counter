part of '../barcode_register.dart';

class DeletableBarcodeViewer extends StatelessWidget {
  static const _horizontalSpacing = 10.0, _verticalSpacing = 10.0;
  static const _chipWidthDefault = 135.0,
      _alertTitle = "削除しますか？",
      _alertCancel = "Cancel",
      _alertOK = "OK";

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
              (barcode, _) => BarcodeChip(
                '${barcode.key}個：${barcode.value}',
                onPressed: () => showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text(_alertTitle),
                    content: Text('${barcode.key}個：${barcode.value}'),
                    actions: [
                      TextButton(
                        child: const Text(_alertCancel),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      TextButton(
                        child: const Text(_alertOK),
                        onPressed: () {
                          vm.remove(barcode.key);
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
