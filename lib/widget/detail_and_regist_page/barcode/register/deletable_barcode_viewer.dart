part of '../barcode_register.dart';

class DeletableBarcodeViewer extends BarcodeViewer {
  const DeletableBarcodeViewer({
    super.key,
    required super.source,
    required BarcodeRegisterViewModel viewmodel,
  }) : vm = viewmodel;

  final BarcodeRegisterViewModel vm;

  @protected
  @override
  BarcodeChip barcodeChip(
    BuildContext context,
    MapEntry<Count, Jam> barcodeData,
  ) => BarcodeChip(
    barcodeData.displayData,
    onPressed: () => showDialog(
      context: context,
      builder: (context) {
        final definication = {
          'キャンセル': () {
            Navigator.pop(context);
          },
          '削除': () {
            vm.remove(barcodeData.jam);
            Navigator.pop(context);
          },
        };

        return AlertDialog(
          title: const Text("削除しますか？"),
          content: Text(barcodeData.displayData),
          actions: definication.entries
              .select(
                (s, _) => TextButton(onPressed: s.value, child: Text(s.key)),
              )
              .toList(),
        );
      },
    ),
  );
}
