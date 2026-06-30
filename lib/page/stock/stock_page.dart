import 'package:darq/darq.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nil/nil.dart';
import 'package:ramyeon_counter/model/stock.dart';
import 'package:ramyeon_counter/page/stock/stock_page_vm.dart';
import 'package:ramyeon_counter/utility/extension_methods/em_theme_data.dart';
import 'package:ramyeon_counter/widget/custom_app_bar.dart';
import 'package:ramyeon_counter/widget/spacing_grid_view/spacing_grid_view.dart';
part './stock_postit_vm.dart';
part './stock_postit.dart';

class StockPage extends StatelessWidget {
  StockPage({super.key, this.brandId, this.packageColor});

  final int? brandId;
  final Color? packageColor;
  final vm = StockPageViewModel();

  @override
  Widget build(BuildContext context) {
    return
    /* Color change */
    Theme(
      data: Theme.of(context).override(packageColor),
      child: Scaffold(
        appBar: DefaultAppBar(
          context,
          '在庫',
          actions: [
            // Select
            ListenableBuilder(
              listenable: vm,
              builder: (context, _) => IconButton(
                icon: switch (vm.isSelectMode) {
                  true => const Icon(Icons.delete_forever),
                  false => const Icon(Icons.delete),
                },
                tooltip: '検索',
                color: switch (vm.isSelectMode) {
                  true => Colors.yellow,
                  false => ColorScheme.of(context).tertiaryContainer,
                },
                onPressed: () {
                  // true->false
                  if (vm.isSelectMode) {
                    final c = vm.post!.count((c) => c.selected);
                    if (c > 0) {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text("タイトル"),
                          content: Text("メッセージ内容"),
                          actions: [
                            TextButton(
                              child: Text("Cancel"),
                              onPressed: () => Navigator.pop(context),
                            ),
                            TextButton(
                              child: Text("OK"),
                              onPressed: () {
                                print(
                                  vm.post!
                                      .where((c) => c.selected)
                                      .select((s, _) => s.stock.id),
                                );
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        ),
                      );
                    }
                    vm.isSelectMode = false;
                  }
                  // true<-false
                  else {
                    vm.isSelectMode = true;
                  }
                },
              ),
            ),
          ],
        ),
        body: FutureBuilder(
          future: Future.wait([vm.loading(brandId)]),
          builder: (context, snapshot) => switch (snapshot.connectionState) {
            .done => SpacingGridView(viewModel: vm),
            _ => nil,
          },
        ),
      ),
    );
  }
}
