// Extention
import 'package:ramyeon_counter/utility/extension_methods/em_theme_data.dart';
// Model
import 'package:ramyeon_counter/model/company.dart';
import 'package:ramyeon_counter/model/repository/company_repository.dart';
import 'package:ramyeon_counter/model/repository/ramyeon_repository.dart';
// Package
import 'dart:math';
import 'package:flutter/material.dart';
// ViewModel
import 'package:ramyeon_counter/page/regist/view_model/regist_page_vm.dart';
// Widget
import 'package:ramyeon_counter/page/regist/barcode_register.dart';
import 'package:ramyeon_counter/widget/custom_app_bar.dart';
import 'package:ramyeon_counter/widget/detail_regist_page/data/ramyeon_data_register.dart';
import 'package:ramyeon_counter/widget/detail_regist_page/tag/tag_register.dart';
import 'package:ramyeon_counter/widget/ramyeon_image/ramyeon_image_register.dart';
import 'package:ramyeon_counter/widget/ramyeon_image/ramyeon_image_register_vm.dart';

class RegistPage extends StatelessWidget {
  RegistPage({super.key, this.brandId, this.packageColor})
    : vm = RegistPageViewModel(brandId);

  /* Const */
  static const firstRowPadding = 10.0;

  final int? brandId;
  final Color? packageColor;
  final RegistPageViewModel vm;
  //String company = '';
  //String brand = '';

  final RamyeonImageRegisterViewModel imageRegisterVM = .new();

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    double viewWidth() => MediaQuery.of(context).size.width;

    return
    /* Color change */
    Theme(
      data: Theme.of(context).override(packageColor),
      child: Scaffold(
        appBar: DefaultAppBar(
          context,
          '登録',
          actions: [
            IconButton(
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
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              /* 1st Row(Image/Data) */
              Container(
                color: ColorScheme.of(context).primaryFixed,
                child: Padding(
                  padding: const .all(firstRowPadding),
                  child: SizedBox(
                    width: double.infinity, // 横∞
                    child: Wrap(
                      alignment: switch (viewWidth()) {
                        < 360 => .center,
                        _ => .spaceBetween,
                      },
                      crossAxisAlignment: .center, // 上下中央揃
                      runAlignment: .center,
                      spacing: firstRowPadding,
                      runSpacing: firstRowPadding,
                      children: [
                        LayoutBuilder(
                          builder:
                              (
                                BuildContext context,
                                BoxConstraints constraints,
                              ) {
                                return Container(
                                  constraints: BoxConstraints(
                                    minWidth: 128,
                                    minHeight: 128,
                                    maxWidth: 256,
                                    maxHeight: 256,
                                  ),
                                  height:
                                      MediaQuery.of(context).size.width * 0.3,
                                  child: RamyeonImageRegister(
                                    imageRegisterVM,
                                    null,
                                    brandId,
                                  ),
                                );
                              },
                        ),
                        Container(
                          constraints: BoxConstraints(
                            maxWidth: switch (viewWidth()) {
                              < 360 => double.infinity, // 改行
                              _ => max(
                                (viewWidth() - firstRowPadding * 2) * 0.5,
                                192,
                              ),
                            },
                          ),
                          //height: 200,
                          child: RamyeonDataRegister(formKey: formKey, vm: vm),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              /* 2nd Row(Tag) */
              Container(
                color: ColorScheme.of(context).primaryFixedDim,
                child: Padding(
                  padding: const EdgeInsets.all(firstRowPadding),
                  child: RamyeonTagRegister(vm),
                ),
              ),
              /* 3rd Row(Barcode) */
              Container(
                color: ColorScheme.of(context).primaryFixed,
                child: Padding(
                  padding: const EdgeInsets.all(firstRowPadding),
                  child: BarcodeRegister(vm.barcodeRegister),
                ),
              ),
            ],
          ),
        ),
        backgroundColor: ColorScheme.of(context).primaryFixedDim,
        //,
      ),
    );
  }
}
