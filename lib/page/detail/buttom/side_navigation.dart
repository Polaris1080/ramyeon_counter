part of 'detail_bottom_appbar.dart';

class SideNavigation extends StatelessWidget {
  const SideNavigation(this.currentPageIndex, {super.key});

  /// From [DetailBottomAppbar] currentPageIndex
  final ValueNotifier<int> currentPageIndex;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: currentPageIndex,
      builder: (context, selected, _) {
        return SizedBox(
          child: Column(
            mainAxisAlignment: .spaceBetween,

            children: [
              ChoiceChip(
                shape: LinearBorder(),
                label: Text('履歴'),
                selected: selected == 0,
                onSelected: (_) => currentPageIndex.value = 0,
                showCheckmark: false,
              ),
              ChoiceChip(
                label: Text('評価'),
                selected: selected == 1,
                onSelected: (_) => currentPageIndex.value = 1,
                showCheckmark: false,
              ),
            ],
          ),
        );
      },
    );
  }
}
