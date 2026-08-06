//Extention
import 'package:ramyeon_counter/utility/extension_methods/em_theme_data.dart';
// Package
import 'package:darq/darq.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
// Model
import 'package:ramyeon_counter/models/model/repository/rating_repository.dart';
import 'package:ramyeon_counter/models/model/repository/stock_repository.dart';
import 'package:ramyeon_counter/utility/extension_type/ramyeon_id.dart';
// (Widget)
import 'package:ramyeon_counter/page/detail/dialog/add_dialog.dart';
import 'package:ramyeon_counter/page/detail/dialog/eat_sheet.dart';
// Partial
part 'side_navigation.dart';
part 'detail_bottom_appbar_page1.dart';
part 'detail_bottom_appbar_page2.dart';

class DetailBottomAppbar extends StatelessWidget {
  /* Setting */
  static const _navigationLabel = ['履歴', '操作'];

  DetailBottomAppbar(this.packageColor, {super.key, required this.ramyeonId});

  /* Argument */
  final Color? packageColor;
  final int ramyeonId;

  /* Value */
  final currentPageIndex = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context)
          .colorOverride(Colors.blue)
          .copyWith(
            elevatedButtonTheme: .new(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
            ),
          ),
      child: BottomAppBar(
        height: 100,
        padding: .zero,
        child: IconTheme(
          data: IconThemeData(color: Theme.of(context).colorScheme.onPrimary),
          child: Row(
            children: [
              SideNavigation(
                currentPageIndex,
                navigationLabel: _navigationLabel,
              ),
              //Spacer(),
              // TODO:Heigth追従しない【影響あり】
              Expanded(
                child: ValueListenableBuilder(
                  valueListenable: currentPageIndex,
                  builder: (context, index, _) => switch (index) {
                    0 => PageOne(
                      ramyeonId: ramyeonId,
                      packageColor: packageColor,
                    ),
                    _ => PageTwo(ramyeonId: ramyeonId),
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
