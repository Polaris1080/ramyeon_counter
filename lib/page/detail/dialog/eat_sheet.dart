// Extention-type
import 'package:ramyeon_counter/utility/extension_methods/em_bool.dart';
import 'package:ramyeon_counter/utility/extension_type/ramyeon_id.dart';
// Model
import 'package:ramyeon_counter/models/model/repository/rating_repository.dart';
// Package
import 'package:flutter/material.dart';
// Widget
import 'package:ramyeon_counter/widget/rating/selecter/rating_selecter.dart';

class EatSheet extends StatelessWidget {
  /* Setting */
  static const _buttonSize = Size(180, 45),
      _maxWidth = 360.0,
      _padding = EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      _spacing = 10.0;

  EatSheet({super.key, required this.id});

  final ValueNotifier<int> vm = .new(0);

  /* Argument */
  final RamyeonId id;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: _maxWidth,
      child: Padding(
        padding: _padding,
        child: Column(
          mainAxisAlignment: .center,
          crossAxisAlignment: .center,
          mainAxisSize: .min,
          spacing: _spacing,
          children: [
            /* Title */
            Text('いかがでしたか？', style: Theme.of(context).textTheme.titleLarge),
            /* Selecter */
            RatingSelecter(vm),
            /* Button */
            ValueListenableBuilder(
              valueListenable: vm,
              builder: (context, rating, _) {
                // 選択されているか
                final isSelected = 1 <= rating && rating <= 10;
                final difinition = {
                  '評価をお願いします': null,
                  '閉じる': () {
                    RatingRepository().consume(id, rating);
                    Navigator.pop(context);
                  },
                }.entries.elementAt(isSelected.toInt);
                return ElevatedButton(
                  onPressed: difinition.value,
                  style: ElevatedButton.styleFrom(minimumSize: _buttonSize),
                  child: Text(
                    difinition.key,
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
