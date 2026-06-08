import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ramyeon_counter/page/stock_page_vm.dart';
import 'package:ramyeon_counter/utility/extension_methods/em_theme_data.dart';
import 'package:ramyeon_counter/widget/custom_app_bar.dart';

class Stockpage extends StatelessWidget {
  const Stockpage({super.key, this.brandId, this.packageColor});

  final int? brandId;
  final Color? packageColor;

  @override
  Widget build(BuildContext context) {
    final viewModel = StockPageViewModel(brandId);

    return
    /* Color change */
    Theme(
      data: Theme.of(context).override(packageColor),
      child: Scaffold(
        appBar: DefaultAppBar(context, '在庫'),
        body: ListenableBuilder(
          listenable: viewModel,
          builder: (context, child) {
            return GridView.builder(
              itemCount: viewModel.count,
              itemBuilder: (context, index) {
                return SizedBox(
                  height: 50,
                  child: Container(
                    color: Colors.blueGrey,
                    child: Column(
                      children: [
                        Text('${viewModel.stock![index].brandId}'),
                        Text(
                          '購入日：${DateFormat('yyyy年MM月dd日').format(viewModel.stock![index].purchaseDate)}',
                        ),
                        Text(
                          '賞味期限：${DateFormat('yyyy年MM月dd日').format(viewModel.stock![index].purchaseDate)}',
                        ),
                        Text('価格：${viewModel.stock![index].price}円'),
                      ],
                    ),
                  ),
                );
              },
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 5,
                crossAxisSpacing: 5,
                childAspectRatio: 1.0,
              ),
            );
          },
        ),
      ),
    );
  }
}
