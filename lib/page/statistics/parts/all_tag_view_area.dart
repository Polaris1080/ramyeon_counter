part of '../statistics_page.dart';

class AllTagViewArea extends StatelessWidget {
  AllTagViewArea(this.vm, {super.key});

  final StatisticsPageViewModel vm;

  /// すべて（のタグを）表示
  final ValueNotifier<bool> seeAll = .new(false);

  @override
  Widget build(BuildContext context) {
    final cs = ColorScheme.of(context);
    return Column(
      children: [
        /* ShowAllTag */
        ValueListenableBuilder(
          valueListenable: seeAll,
          builder: (context, flag, _) => OutlinedButton.icon(
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.transparent, // hover Color
              backgroundColor: flag ? cs.tertiaryFixedDim : cs.tertiaryFixed,
              iconColor: cs.tertiaryContainer,
              side: BorderSide(color: cs.tertiary, width: 2.0),
              iconSize: 36,
            ),
            icon: Icon(
              flag ? Icons.arrow_drop_down_rounded : Icons.arrow_right_rounded,
            ),
            label: Text(
              "すべて表示",
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: cs.onTertiaryFixed,
                fontFamily: "ZenMaruGothic",
              ),
            ),
            onPressed: () => seeAll.flip(),
          ),
        ),
        /* AllTag */
        ValueListenableBuilder(
          valueListenable: seeAll,
          builder: (context, flag, child) =>
              Visibility.maintain(visible: flag, child: child!),
          child: FutureBuilder(
            future: vm.allTagData,
            builder: (context, snapshot) => switch (snapshot.data) {
              List<TagData> data => Wrap(
                spacing: 10.0,
                runSpacing: 10.0,
                children: [
                  ...data.select((s, i) {
                    final cs = ColorScheme.fromSeed(
                      seedColor: StatisticsPage.rainbow[i % 7],
                    );
                    return Chip(
                      side: BorderSide(color: cs.primary, width: 1.5),
                      padding: EdgeInsets.all(0),
                      label: Text(
                        s.tag,
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: cs.onTertiaryFixed,
                          fontFamily: "ZenKakuGothicNew",
                        ),
                      ),
                      backgroundColor: cs.primaryFixed,
                    );
                  }),
                ],
              ),
              _ => const SizedBox(),
            },
          ),
        ),
      ],
    );
  }
}
