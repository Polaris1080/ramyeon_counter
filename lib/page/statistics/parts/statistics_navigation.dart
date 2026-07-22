part of '../statistics_page.dart';

class StatisticsNavigation extends StatelessWidget {
  /* Setting */
  static const _duration = Duration(milliseconds: 500);

  const StatisticsNavigation(this.selected, {super.key});

  /* Argument */
  /// From [StatisticsPage]
  final ValueNotifier<int> selected;

  @override
  Widget build(BuildContext context) {
    /* Color Setting */
    final cs = ColorScheme.of(context),
        backgroundColor = cs.tertiaryFixedDim,
        textColor = cs.onTertiaryFixed,
        selectedIconColor = cs.onTertiaryFixedVariant,
        selectedBackgroundColor = cs.tertiaryFixed;

    return ValueListenableBuilder(
      valueListenable: selected,
      builder: (_, selectedIndex, _) => NavigationBarTheme(
        data: NavigationBarThemeData(
          iconTheme: WidgetStateProperty<IconThemeData?>.fromMap({
            WidgetState.selected: IconThemeData(color: selectedIconColor),
            WidgetState.any: IconThemeData(color: textColor),
          }),
          labelTextStyle: WidgetStatePropertyAll(TextStyle(color: textColor)),
        ),
        child: NavigationBar(
          animationDuration: _duration,
          backgroundColor: backgroundColor,
          indicatorColor: selectedBackgroundColor,
          indicatorShape: CircleBorder(),
          destinations: [
            ...<({IconData icon, String label, String? tooltip})>[
              /* 0:RankingTagSubPage */
              (icon: Icons.tag, label: 'タグ', tooltip: null),
              /* 1:EatPieChart */
              (icon: Icons.local_dining, label: '個数', tooltip: '食べた個数'),
              /* 2:StockBarChart */
              (icon: Icons.currency_yen, label: '金額', tooltip: '購入金額'),
              /* 3:RankingRatingSubPage */
              (icon: Icons.favorite, label: '評価', tooltip: null),
            ].select((s, _) {
              final (:icon, :label, :tooltip) = s;
              return NavigationDestination(
                icon: Icon(icon),
                label: label,
                tooltip: tooltip,
              );
            }),
          ],
          selectedIndex: selectedIndex,
          onDestinationSelected: (index) => selected.value = index,
        ),
      ),
    );
  }
}
