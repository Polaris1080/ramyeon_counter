// Extention

import 'package:flutter/material.dart';
import 'package:ramyeon_counter/page/regist/view_model/regist_page_vm.dart';

class RamyeonDataRegister extends StatelessWidget {
  const RamyeonDataRegister({
    super.key,
    required this.formKey,
    required this.vm,
  });

  final GlobalKey<FormState> formKey;
  final RegistPageViewModel vm;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: ListenableBuilder(
        listenable: vm,
        builder: (context, child) {
          return Column(
            mainAxisSize: .min,
            spacing: 8,
            children: [
              TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: '商品名',
                ),
                onChanged: (String value) {
                  vm.brand = value;
                },
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                initialValue: vm.brand,
              ),
              TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: '会社名',
                ),
                onChanged: (String value) {
                  vm.company = value;
                },
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                initialValue: vm.company,
              ),
            ],
          );
        },
      ),
    );
  }
}
