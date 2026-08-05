// Extention-type
import 'package:ramyeon_counter/utility/extension_methods/em_bool.dart';
import 'package:ramyeon_counter/utility/extension_type/ramyeon_id.dart';
// Model
import 'package:ramyeon_counter/model/repository/rating_repository.dart';
// Package
import 'package:flutter/material.dart';
// Widget
import 'package:ramyeon_counter/widget/rating/selecter/rating_selecter.dart';

class EatSheet extends StatelessWidget {
  /* Setting */
  static const _padding = EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      _spacing = 10.0,
      _maxWidth = 360.0;

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
            Theme(
              data: Theme.of(context).copyWith(
                elevatedButtonTheme: .new(
                  style: ElevatedButton.styleFrom(minimumSize: .new(180, 45)),
                ),
              ),
              child: ValueListenableBuilder(
                valueListenable: vm,
                builder: (context, rating, _) {
                  final isSelected = 1 <= rating && rating <= 10;
                  final difinition = {
                    '評価をお願いします': null,
                    '閉じる': () {
                      RatingRepository().consume(id, rating);
                      Navigator.pop(context);
                    },
                  };
                  return ElevatedButton(
                    onPressed: difinition.values.toList()[isSelected.toInt],
                    child: Text(
                      difinition.keys.toList()[isSelected.toInt],
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
