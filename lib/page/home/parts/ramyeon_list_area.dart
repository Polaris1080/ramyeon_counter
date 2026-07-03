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
        future: RamyeonRepository().countByBrand(vm.searchWord),
        builder: (context, snapshot) => switch (snapshot.connectionState) {
          /* 完了 */
          .done => switch (snapshot.data) {
            /* ある */
            int count when count > 0 => RamyeonListView(
              snapshot.data as int,
              vm.orderBy,
              vm.isCatalogMode,
            ),
            /* ない */
            int count when count == 0 => Center(
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
