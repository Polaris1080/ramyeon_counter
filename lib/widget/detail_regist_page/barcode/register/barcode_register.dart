// Package
import 'dart:io';
import 'package:darq/darq.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// ViewModel
import 'barcode_register_vm.dart';
// Partical
part 'barcode_entry.dart';
part 'deletable_barcode_viewer.dart';
part 'deletable_chip.dart';
part 'quantity_selector.dart';

class BarcodeRegister extends StatelessWidget {
  static const _verticalSpacing = 10.0;

  const BarcodeRegister(this.vm, {super.key});

  final BarcodeRegisterViewModel vm;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          spacing: _verticalSpacing,
          children: [
            BarcodeEntry(vm),
            QuantitySelector(vm),
            DeletableBarcodeViewer(vm),
          ],
        ),
      ],
    );
  }
}

/* 後で使うかも */
// class BarcodeFormatter extends TextInputFormatter {
//   @override
//   TextEditingValue formatEditUpdate(
//     TextEditingValue oldValue,
//     TextEditingValue newValue,
//   ) {
//     final text = newValue.text;
//     if (text.isEmpty) {
//       return newValue;
//     }
//     final value = int.tryParse(text.replaceAll(',', ''));
//     if (value == null) {
//       return oldValue;
//     }
//     // 3桁ごとにカンマを挿入　例：1234567 → 1,234,567
//     newValue = TextEditingValue(
//       text: value.toString().replaceAllMapped(
//         RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
//         (Match m) {
//           return '${m[1]},';
//         },
//       ),
//     );
//     // カーソルを末尾に移動
//     newValue = newValue.copyWith(
//       selection: TextSelection.collapsed(offset: newValue.text.length),
//     );
//     return newValue;
//   }
// }
