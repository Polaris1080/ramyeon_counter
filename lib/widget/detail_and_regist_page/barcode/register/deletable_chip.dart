part of 'barcode_register.dart';

class DeletableChip extends StatelessWidget {
  static const _chipWidthDefault = 135.0,
      _alertTitle = "削除しますか？",
      _alertCancel = "Cancel",
      _alertOK = "OK";

  const DeletableChip(
    this.data, {
    super.key,
    this.onDeleted,
    this.chipWidth = _chipWidthDefault,
  });

  final String data;
  final double chipWidth;
  final void Function()? onDeleted;

  @override
  Widget build(BuildContext context) {
    return ActionChip(
      label: SizedBox(
        width: chipWidth,
        child: Text(data, textAlign: .center),
      ),
      padding: EdgeInsets.all(0),
      onPressed: () => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text(_alertTitle),
          content: Text(data),
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
                onDeleted?.call();
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
