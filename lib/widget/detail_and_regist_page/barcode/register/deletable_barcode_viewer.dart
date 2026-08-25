part of '../barcode_register.dart';

class const DeletableBarcodeViewer({
  super.key,
  required super.source,
  required final BarcodeRegisterViewModel vm,
}) extends BarcodeViewer {
  @protected
  @override
  Widget barcodeChip(BuildContext context, MapEntry<Count, Jam> source) =>
      DeletableBarcodeChip(
        source.displayData,
        /* Delete dialog */
        onDeleted: () => showDialog(
          context: context,
          builder: (context) {
            final definication = {
              'キャンセル': () {
                Navigator.pop(context);
              },
              '削除': () {
                vm.removeButtonClicked(source.key);
                Navigator.pop(context);
              },
            };

            return AlertDialog(
              title: const Text("削除しますか？"),
              content: Text(source.displayData),
              actions: definication.entries
                  .map(
                    (e) => TextButton(onPressed: e.value, child: Text(e.key)),
                  )
                  .toList(),
            );
          },
        ),
      );
}
