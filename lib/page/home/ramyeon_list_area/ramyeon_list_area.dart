// Package
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// Model
import 'package:ramyeon_counter/models/context/ramyeon/ramyeon_list_data.dart';
import 'package:ramyeon_counter/models/context/ramyeon/behind/ramyeon_list_data_context.dart';

// Other
import '../home_page.dart';

// Partical
part 'normal_tile.dart';
part 'catarog_tile.dart';

class const RamyeonListArea(final HomePageViewModel vm, {super.key})
    extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: vm,
      builder: (context, _) => FutureBuilder(
        // 検索し個数を求める
        future: RamyeonListDataContext().readByBrand(
          vm.searchWord,
          order: vm.orderBy == .normal ? null : vm.orderBy.label,
        ),
        builder: (context, snapshot) => switch (snapshot.connectionState) {
          /* 完了 */
          .done => switch (snapshot.data) {
            /* ある */
            List<RamyeonListData> count when count.isNotEmpty =>
              ListView.builder(
                itemCount: count.length,
                itemBuilder: (context, index) {
                  RamyeonListData d = count[index];
                  return ListenableBuilder(
                    listenable: vm,
                    builder: (context, child) {
                      return vm.isCatalogMode
                          ? NormalTile(data: d)
                          : CatarogTile(data: d);
                    },
                  );
                },
              ),
            // RamyeonListView(
            //   snapshot.data as int,
            //   vm.orderBy,
            //   vm.isCatalogMode,
            // ),
            /* ない */
            List<RamyeonListData> count when count.isEmpty => Center(
              child: Text(
                '見つかりません',
                style: TextStyle(
                  fontFamily: 'ZenKakuGothic',
                  fontSize: 24,
                  fontWeight: .w500,
                ),
              ),
            ),
            /* エラー */
            _ => Center(
              child: Text(
                'エラーが発生しました',
                style: TextStyle(
                  fontFamily: 'ZenKakuGothic',
                  fontSize: 24,
                  fontWeight: .w500,
                ),
              ),
            ),
          },
          /* 途中 */
          _ => LinearProgressIndicator(color: ColorScheme.of(context).tertiary),
        },
      ),
    );
  }
}
