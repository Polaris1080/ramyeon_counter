import 'package:flutter/material.dart';

class AddDialog extends StatelessWidget {
  const AddDialog({super.key, required this.productName});

  final Divider separator = const Divider(
    height: 10,
    thickness: 1,
    color: Colors.grey,
  );

  final String productName;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('追加'),
      content: //ObscuredTextFieldSample(),
      Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(children: [Text('品名'), Spacer(), Text(productName)]),
          separator,
          Row(
            children: [
              Text('個数'),
              Spacer(),
              SizedBox(
                width: 100,
                child: SubmenuButton(
                  menuChildren: <Widget>[
                    MenuItemButton(onPressed: () => {}, child: Text('1')),
                    MenuItemButton(onPressed: () => {}, child: Text('5')),
                  ],
                  child: const Text('1/5'),
                ),
              ),
            ],
          ),
          separator,
          Row(children: [Text('価格(￥)'), Spacer(), ObscuredTextFieldSample()]),
        ],
      ),
      actions: [
        TextButton(
          style: TextButton.styleFrom(
            textStyle: Theme.of(context).textTheme.labelLarge,
          ),
          child: const Text('キャンセル'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          style: TextButton.styleFrom(
            textStyle: Theme.of(context).textTheme.labelLarge,
          ),
          child: const Text('追加'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}

class ObscuredTextFieldSample extends StatelessWidget {
  const ObscuredTextFieldSample({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 100,
      child: TextField(
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          //labelText: 'P',
        ),
      ),
    );
  }
}
