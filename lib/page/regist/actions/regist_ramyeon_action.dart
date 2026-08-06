// Extention

import 'package:flutter/material.dart';
import 'package:ramyeon_counter/models/model/company.dart';
import 'package:ramyeon_counter/models/repository/company_repository.dart';
import 'package:ramyeon_counter/models/repository/ramyeon_repository.dart';
import 'package:ramyeon_counter/page/regist/view_model/regist_page_vm.dart';

class RegistRamyeonAction extends StatelessWidget {
  const RegistRamyeonAction({
    super.key,
    required this.formKey,
    required this.vm,
  });

  final GlobalKey<FormState> formKey;
  final RegistPageViewModel vm;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.add),
      tooltip: '登録',
      onPressed: () async {
        if (formKey.currentState!.validate()) {
          // companyID解決
          Company? company = await CompanyRepository().readByCompany(
            vm.company,
          );
          int companyId = company != null
              ? company.id
              : await CompanyRepository().insert(vm.company);
          await RamyeonRepository().insert(
            .new(
              id: -1,
              companyId: companyId,
              brand: vm.brand,
              company: vm.company,
              tag: [],
            ),
          );
          if (context.mounted) {
            // return [HomePage]
            Navigator.of(context).pop();
          }
        }
      },
    );
  }
}
