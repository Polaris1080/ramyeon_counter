part of '../statistics_page.dart';

class AllTagViewArea extends StatelessWidget {
  /* Setting */
  static const _spacing = Size(10.0, 10.0);

  AllTagViewArea(this.vm, {super.key});

  /* Value */
  final StatisticsPageViewModel vm;

  /// すべて（のタグを）表示
  final ValueNotifier<bool> seeAll = .new(false);

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: _spacing.height,
      children: [
        /* ShowAllTag */
        ValueListenableBuilder(
          valueListenable: seeAll,
          builder: (context, flag, _) {
            final cs = ColorScheme.of(context);
            return OutlinedButton.icon(
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.transparent, // hover Color
                backgroundColor: cs.tertiaryFixed,
                iconColor: cs.tertiaryContainer,
                side: BorderSide(color: cs.tertiary, width: 2.0),
                iconSize: 36,
              ),
              icon: Icon(
                flag
                    ? Icons.arrow_drop_down_rounded
                    : Icons.arrow_right_rounded,
              ),
              label: Text(
                "すべてのタグを表示",
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: cs.onTertiaryFixed,
                  fontFamily: "ZenMaruGothic",
                ),
              ),
              onPressed: () => seeAll.flip(),
            );
          },
        ),
        /* AllTag */
        ValueListenableBuilder(
          valueListenable: seeAll,
          builder: (context, v, c) => Visibility(visible: v, child: c!),
          child: FutureBuilder(
            future: vm.allTagData,
            builder: (context, snapshot) => switch (snapshot.data) {
              List<TagData> data => Wrap(
                spacing: _spacing.width,
                runSpacing: _spacing.height,
                children: [
                  ...data.select((s, i) {
                    final rcs = splitRainbow(i);
                    // TODO:TagChip
                    return Chip(
                      side: BorderSide(color: rcs.primary, width: 1.5),
                      padding: EdgeInsets.all(0),
                      label: Text(
                        s.tag,
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: rcs.onTertiaryFixed,
                          fontFamily: "ZenKakuGothicNew",
                        ),
                      ),
                      backgroundColor: rcs.primaryFixed,
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

  ColorScheme splitRainbow(int i) => ColorScheme.fromSeed(
    seedColor: [
      Colors.red,
      Colors.orange,
      Colors.yellow,
      Colors.green,
      Colors.cyan,
      Colors.blue,
      Colors.purple,
    ][i % 7],
  );
}
