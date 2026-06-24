import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ramyeon_counter/model/ramyeon.dart';
import 'package:ramyeon_counter/model/ramyeon_list_data.dart';
import 'package:ramyeon_counter/model/repository/rating_repository.dart';
import 'package:ramyeon_counter/model/repository/stock_repository.dart';
import 'package:ramyeon_counter/widget/add_dialog.dart';
import 'package:ramyeon_counter/widget/eat_sheet.dart';

class DetailBottomAppbar extends StatelessWidget {
  DetailBottomAppbar(this.packageColor, {super.key, required this.ramyeonId});

  final Color? packageColor;
  final int ramyeonId;
  final choiceChipSelected = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      height: 100,
      padding: .all(10),
      color: Colors.blue,
      child: IconTheme(
        data: IconThemeData(color: Theme.of(context).colorScheme.onPrimary),
        child: SizedBox(
          //width: 330,
          child: Row(
            mainAxisAlignment: .spaceBetween,
            children: [
              /* Selector */
              ValueListenableBuilder(
                valueListenable: choiceChipSelected,
                builder: (context, selected, _) {
                  return SizedBox(
                    child: Column(
                      mainAxisAlignment: .spaceBetween,

                      children: [
                        ChoiceChip(
                          label: Text('履歴'),
                          selected: selected == 0,
                          onSelected: (_) => choiceChipSelected.value = 0,
                          showCheckmark: false,
                        ),
                        ChoiceChip(
                          label: Text('評価'),
                          selected: selected == 1,
                          onSelected: (_) => choiceChipSelected.value = 1,
                          showCheckmark: false,
                        ),
                      ],
                    ),
                  );
                },
              ),

              ValueListenableBuilder(
                valueListenable: choiceChipSelected,
                builder: (context, value, w) {
                  return Visibility(visible: value == 0, child: w!);
                },
                child: Row(
                  spacing: 10,
                  children: [
                    /* History_Rating */
                    FutureBuilder(
                      future: RatingRepository().countByBrandId(ramyeonId),
                      builder: (context, snapshot) => ActionChip(
                        avatar: const Icon(Icons.star),
                        label: const Text('評価'),
                        onPressed: switch (snapshot.data) {
                          int count when count > 0 => () {
                            context.push(
                              '/detail/rating/$ramyeonId',
                              extra: packageColor,
                            );
                          },
                          _ => null,
                        },
                      ),
                      initialData: 0,
                    ),
                    /* History_Price */
                    FutureBuilder(
                      future: StockRepository().countByBrandId(ramyeonId),
                      builder: (context, snapshot) => ActionChip(
                        avatar: const Icon(Icons.currency_yen),
                        label: const Text('価格'),
                        onPressed: switch (snapshot.data) {
                          int count when count > 0 => () {
                            context.push(
                              '/detail/price/$ramyeonId',
                              extra: packageColor,
                            );
                          },
                          _ => null,
                        },
                      ),
                      initialData: 0,
                    ),
                    ActionChip(
                      avatar: Icon(Icons.favorite),
                      label: const Text('在庫'),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
              ValueListenableBuilder(
                valueListenable: choiceChipSelected,
                builder: (context, value, w) {
                  return Visibility(visible: value == 1, child: w!);
                },
                child: Row(
                  spacing: 10,
                  children: [
                    Row(
                      children: [
                        ActionChip(
                          onPressed: () {
                            showDialog<void>(
                              context: context,
                              builder: (BuildContext context) {
                                return AddDialog(productName: '神チャンソプ');
                              },
                            );
                          },
                          label: const Text('追加'),
                        ),
                        ActionChip(
                          onPressed: () {
                            showModalBottomSheet<void>(
                              context: context,
                              builder: (BuildContext context) {
                                return EatSheet();
                              },
                            );
                          },
                          label: const Text('消費'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
