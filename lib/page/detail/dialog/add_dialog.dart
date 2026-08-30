import 'package:darq/darq.dart';
import 'package:flutter/material.dart';

class const AddDialog({super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const dialogSpacing = Size(10.0, 10.0); //【Upper/Lower padding】
    return Theme(
      data: Theme.of(context).copyWith(
        /* Button theme */
        textButtonTheme: .new(
          style: TextButton.styleFrom(
            textStyle: Theme.of(context).textTheme.labelLarge,
          ),
        ),
      ),
      child: AlertDialog(
        constraints: const BoxConstraints(maxWidth: 200.0), //【Dialog max width】
        insetPadding: const EdgeInsets.all(10.0), //【Dialog padding】
        contentPadding: .symmetric(
          horizontal: dialogSpacing.width,
          vertical: dialogSpacing.height,
        ),
        actionsPadding: .fromLTRB(
          dialogSpacing.width,
          0,
          dialogSpacing.width,
          dialogSpacing.height,
        ),
        content: Table(
          columnWidths: <int, TableColumnWidth>{
            0: IntrinsicColumnWidth(),
            1: FixedColumnWidth(10.0), //【Table item spacing】
            2: MinColumnWidth(FlexColumnWidth(), FixedColumnWidth(100)),
          },
          defaultVerticalAlignment: .middle,
          children: [
            // TODO:ファイル分割
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
                  _spacer, // Column:1
                  TableCell(child: definication.value),
                ],
              ),
            ),
          ],
        ),
        actions: [_cancelButton, _appendButton],
      ),
    );
  }

  /* Table */
  TableCell get _spacer => TableCell(child: const SizedBox());

  /* Button */
  Widget get _appendButton => Builder(
    builder: (context) => TextButton(
      onPressed: () {
        // TODO:Append
        Navigator.of(context).pop();
      },
      child: const Text('追加'),
    ),
  );

  Widget get _cancelButton => Builder(
    builder: (context) => TextButton(
      onPressed: () {
        Navigator.of(context).pop();
      },
      child: const Text('キャンセル'),
    ),
  );
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
