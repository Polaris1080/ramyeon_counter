import 'package:darq/darq.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ramyeon_counter/widget/detail_regist_page/barcode/register/barcode_register_vm.dart';

part 'deletable_barcode_viewer.dart';
part 'deletable_chip.dart';

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
                            helperText: '数字８／１３桁',
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
              /* 3rd Columu */
              DeletableBarcodeViewer(vm),
            ],
          ),
        ),
      ],
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
