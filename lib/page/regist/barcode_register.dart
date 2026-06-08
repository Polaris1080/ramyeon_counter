import 'package:darq/darq.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ramyeon_counter/page/regist/view_model/barcode_register_vm.dart';

class BarcodeRegister extends StatelessWidget {
  const BarcodeRegister(this.vm, {super.key});

  final BarcodeRegisterViewModel vm;

  static const countMax = 5;
  static const _fullLengthCode = 65248;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          //color: Colors.amberAccent,
          width: 360,
          child: Column(
            spacing: 10,

            children: [
              Column(
                spacing: 10,
                children: [
                  // 1st Columu
                  Row(
                    spacing: 10,
                    mainAxisAlignment: .center,
                    children: [
                      IconButton(
                        onPressed: null,
                        icon: Icon(Icons.barcode_reader),
                      ),
                      SizedBox(
                        width: 150,
                        child: TextFormField(
                          autovalidateMode: .onUserInteraction,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'バーコード',
                            helperText: '数字８桁or１３桁',
                          ),
                          onChanged: (value) {
                            vm.barcodeText = value;
                          },
                          // only number
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            //BarcodeFormatter(),
                          ],
                          validator: (value) {
                            if (value != null &&
                                value.isNotEmpty &&
                                !RegExp(r'^\d{8}$|^\d{13}$').hasMatch(value)) {
                              return '有効なメールアドレスを入力してください';
                            }
                            return null;
                          },
                        ),
                      ),
                      IconButton(onPressed: vm.append, icon: Icon(Icons.add)),
                    ],
                  ),
                  /* 2nd Columu (Selecter) */
                  ListenableBuilder(
                    listenable: vm,
                    builder: (context, _) {
                      return SegmentedButton<int>(
                        segments: [
                          for (var i in RangeIterable(1, 1 + countMax))
                            ButtonSegment<int>(
                              value: i,
                              label: Text(
                                i == vm.countSelected
                                    ? '${String.fromCharCode(i.toString().codeUnitAt(0) + _fullLengthCode)}個'
                                    : '$i',
                              ),
                              tooltip: '個数',
                              enabled: !vm.source.containsKey(i),
                            ),
                        ],
                        selected: {vm.countSelected},
                        onSelectionChanged: vm.countChanged,
                        showSelectedIcon: false,
                      );
                    },
                  ),
                ],
              ),
              /* 3rd Columu (Viewer) */
              ListenableBuilder(
                listenable: vm,
                builder: (context, _) {
                  return Wrap(
                    children: [
                      for (var entry in vm.source.entries)
                        DeletableChip.fromBarcode(
                          entry,
                          onDel: () => vm.remove(entry.key),
                        ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class DeletableChip extends StatelessWidget {
  const DeletableChip(this.data, {super.key, this.onDel});

  DeletableChip.fromBarcode(
    MapEntry<int, int> barcode, {
    Key? key,
    Function()? onDel,
  }) : this('${barcode.key}個：${barcode.value}', key: key, onDel: onDel);

  final String data;
  final void Function()? onDel;

  @override
  Widget build(BuildContext context) {
    return ActionChip(
      label: Text(data),
      padding: EdgeInsets.all(0),
      onPressed: () => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("削除しますか？"),
          content: Text(data),
          actions: [
            TextButton(
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: const Text("OK"),
              onPressed: () {
                onDel?.call();
                //vm.remove(count);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class BarcodeFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final text = newValue.text;
    if (text.isEmpty) {
      return newValue;
    }
    final value = int.tryParse(text.replaceAll(',', ''));
    if (value == null) {
      return oldValue;
    }
    // 3桁ごとにカンマを挿入　例：1234567 → 1,234,567
    newValue = TextEditingValue(
      text: value.toString().replaceAllMapped(
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
        (Match m) {
          return '${m[1]},';
        },
      ),
    );
    // カーソルを末尾に移動
    newValue = newValue.copyWith(
      selection: TextSelection.collapsed(offset: newValue.text.length),
    );
    return newValue;
  }
}
