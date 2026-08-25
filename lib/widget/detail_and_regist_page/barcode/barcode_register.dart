// Extension
import 'package:ramyeon_counter/utility/extension_methods/em_num.dart';

import 'extension/em_barcode_data.dart';
import 'extension/count.dart';
import 'extension/jam.dart';

// Package
import 'dart:io';

import 'package:darq/darq.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Other
import 'barcode_viewer.dart';
import 'barcode_register_vm.dart';
import 'chip/deletable_barcode_chip.dart';

// Partical
part 'register/barcode_entry.dart';
part 'register/deletable_barcode_viewer.dart';
part 'register/quantity_selector.dart';

class const BarcodeRegister(
  @protected final BarcodeRegisterViewModel vm, {
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 10.0, // Vertical spacing.
      children: [
        /* Barcode */
        BarcodeEntry(vm),
        /* Selector */
        QuantitySelector(vm),
        /* Viewer */
        ListenableBuilder(
          listenable: vm,
          builder: (context, _) =>
              DeletableBarcodeViewer(source: vm.source, vm: vm),
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
