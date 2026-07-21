part of 'detail_bottom_appbar.dart';

class SideNavigation extends StatelessWidget {
  const SideNavigation(
    this.currentPageIndex, {
    super.key,
    required this.navigationLabel,
  });

  /* Arguments */
  /// From [DetailBottomAppbar] currentPageIndex
  final ValueNotifier<int> currentPageIndex;

  final List<String> navigationLabel;

  @override
  Widget build(BuildContext context) {
    final cs = ColorScheme.of(context);
    // Color
    final backgroundColor = Colors.grey[400], borderColor = Colors.blueGrey;
    // Container:Border
    final outerBorderSetting = BorderSide(color: borderColor, width: 2.0),
        outerBorder = BoxDecoration(
          color: backgroundColor,
          border: BoxBorder.fromLTRB(
            top: outerBorderSetting,
            right: outerBorderSetting,
          ),
        );
    // NavigationDestination
    final chipTheme = ChipThemeData(
      // Border
      shape: LinearBorder.bottom(
        side: BorderSide(color: borderColor),
        size: 1.0,
      ),
      // Color
      backgroundColor: cs.surface,
      selectedColor: cs.secondaryFixedDim,
      // Padding
      padding: const .all(5.0),
      labelPadding: .zero,
      // Other
      labelStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
        color: cs.onSecondaryFixed,
        fontFamily: "ZenMaruGothic",
      ),
      showCheckmark: false,
    );

    return Theme(
      data: Theme.of(context).copyWith(chipTheme: chipTheme),
      child: Container(
        decoration: outerBorder,
        child: Column(
          mainAxisAlignment: .start,
          /* NavigationDestination */
          children: navigationLabel
              .select(
                (text, i) => ValueListenableBuilder(
                  valueListenable: currentPageIndex,
                  builder: (context, index, _) => ChoiceChip(
                    label: Text(text),
                    selected: index == i,
                    onSelected: (_) => currentPageIndex.value = i,
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
