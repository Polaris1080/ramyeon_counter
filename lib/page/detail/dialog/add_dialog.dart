import 'package:darq/darq.dart';
import 'package:flutter/material.dart';

class AddDialog extends StatelessWidget {
  /* Setting */
  static const _dialogPadding = 10.0, _dialogWidth = 200.0;
  static const _dialogSpacing = Size(10.0, 10.0), _rowSpacing = 10.0;

  const AddDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      /* Size */
      constraints: BoxConstraints(maxWidth: _dialogWidth),
      insetPadding: const EdgeInsets.all(_dialogPadding),
      /* Spacing */
      contentPadding: .symmetric(
        horizontal: _dialogSpacing.width,
        vertical: _dialogSpacing.height,
      ),
      actionsPadding: .fromLTRB(
        _dialogSpacing.width,
        0,
        _dialogSpacing.width,
        _dialogSpacing.height,
      ),
      content: Table(
        columnWidths: <int, TableColumnWidth>{
          0: IntrinsicColumnWidth(),
          1: FixedColumnWidth(_rowSpacing),
          2: MinColumnWidth(FlexColumnWidth(), FixedColumnWidth(100)),
        },
        defaultVerticalAlignment: .middle,
        children: [
          ...{
            '個数': SubmenuButton(
              menuChildren: <Widget>[
                MenuItemButton(onPressed: () => {}, child: Text('1')),
                MenuItemButton(onPressed: () => {}, child: Text('5')),
              ],
              child: const Text('1/5'),
            ),
            '価格': ObscuredTextFieldSample(),
          }.entries.select(
            (definication, _) => TableRow(
              children: [
                TableCell(
                  child: Text(
                    definication.key,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                TableCell(child: const SizedBox()),
                TableCell(child: definication.value),
              ],
            ),
          ),
        ],
      ),
      actions: [
        ...{
          'キャンセル': () {
            Navigator.of(context).pop();
          },
          '追加': () {
            // TODO:Append
            Navigator.of(context).pop();
          },
        }.entries.select(
          (definication, _) => TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            onPressed: definication.value,
            child: Text(definication.key),
          ),
        ),
      ],
    );
  }
}

class ObscuredTextFieldSample extends StatelessWidget {
  const ObscuredTextFieldSample({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: .new(maxWidth: 150),
      child: TextField(
        expands: false,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          //labelText: 'P',
        ),
      ),
    );
  }
}
