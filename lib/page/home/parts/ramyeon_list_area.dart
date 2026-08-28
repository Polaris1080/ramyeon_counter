part of '../home_page.dart';

class RamyeonListArea extends StatelessWidget {
  const RamyeonListArea(this.vm, {super.key});

  final HomePageViewModel vm;

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
                      return vm.isCatalogMode ? TileA(data: d) : TileB(data: d);
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
