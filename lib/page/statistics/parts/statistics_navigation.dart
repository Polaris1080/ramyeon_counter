part of '../statistics_page.dart';

class StatisticsNavigation extends StatelessWidget {
  static const _duration = Duration(milliseconds: 500);

  const StatisticsNavigation(this.selected, {super.key});

  final ValueNotifier<int> selected;

  @override
  Widget build(BuildContext context) {
    /* Color Setting */
    final backgroundColor = ColorScheme.of(context).tertiaryFixedDim;
    final textColor = ColorScheme.of(context).onTertiaryFixed;
    final selectedIconColor = ColorScheme.of(context).onTertiaryFixedVariant;
    final selectedBackgroundColor = ColorScheme.of(context).tertiaryFixed;

    return ValueListenableBuilder(
      valueListenable: selected,
      builder: (context, selectedIndex, _) => NavigationBarTheme(
        data: NavigationBarThemeData(
          iconTheme: WidgetStateProperty.resolveWith(
            (ws) => switch (ws) {
              Set<WidgetState>() when ws.contains(WidgetState.selected) =>
                IconThemeData(color: selectedIconColor),
              _ => IconThemeData(color: textColor),
            },
          ),
          labelTextStyle: .all(TextStyle(color: textColor)),
        ),
        child: NavigationBar(
          animationDuration: _duration,
          backgroundColor: backgroundColor,
          indicatorColor: selectedBackgroundColor,
          indicatorShape: CircleBorder(),
          selectedIndex: selectedIndex,
          destinations: const [
            /* 0:RankingTagSubPage */
            NavigationDestination(
              icon: Icon(Icons.tag),
              label: 'タグ',
              tooltip: 'タグ',
            ),
            /* 1:EatPieChart */
            NavigationDestination(
              icon: Icon(Icons.local_dining),
              label: '個数',
              tooltip: '食べた個数',
            ),
            /* 2:StockBarChart */
            NavigationDestination(
              icon: Icon(Icons.currency_yen),
              label: '金額',
              tooltip: '購入金額',
            ),
            /* 3:RankingRatingSubPage */
            NavigationDestination(
              icon: Icon(Icons.favorite),
              label: '評価',
              tooltip: '評価',
            ),
          ],
          onDestinationSelected: (index) => selected.value = index,
        ),
      ),
    );
  }
}
