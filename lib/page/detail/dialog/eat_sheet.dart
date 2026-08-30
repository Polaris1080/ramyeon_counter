// Annotation
import 'package:ramyeon_counter/utility/annotations/viewmodel_annotation.dart';

// Extention
import 'package:ramyeon_counter/utility/extension_types/ramyeon_id.dart';

// Package
import 'package:flutter/material.dart';

// Model
import 'package:ramyeon_counter/models/model/ramyeon/repository/rating_repository.dart';

// Widget
import 'package:ramyeon_counter/widget/rating/rating_selecter.dart';
import 'package:ramyeon_counter/widget/rating/base/rating_widget_base.dart';

// Partial
part 'eat_sheet_vm.dart';

class const EatSheet({super.key, required final EatSheetViewModel vm})
    extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        /* Button theme */
        elevatedButtonTheme: .new(
          style: ElevatedButton.styleFrom(
            minimumSize: Size(180, 45), //【Button size】
            textStyle: Theme.of(context).textTheme.labelLarge,
          ),
        ),
      ),
      child: SizedBox(
        width: 360.0, //【Sheet max width】
        child: Padding(
          padding: .symmetric(vertical: 15, horizontal: 10), //【Sheet padding】
          child: Column(
            mainAxisAlignment: .center,
            crossAxisAlignment: .center,
            mainAxisSize: .min,
            spacing: 10.0, //【Sheet item spacing】
            children: [
              Text('いかがでしたか？', style: Theme.of(context).textTheme.titleLarge),
              RatingSelecter(vm.evaluation),
              ListenableBuilder(
                listenable: vm,
                builder: (_, _) => vm.isSelected ? consumeButton : waitButton,
              ),
            ],
          ),
        ),
      ),
    );
  }

  /* Button */
  Widget get consumeButton => Builder(
    builder: (context) => ElevatedButton(
      onPressed: () {
        vm.consume();
        Navigator.pop(context);
      },
      child: const Text('閉じる'),
    ),
  );

  Widget get waitButton =>
      ElevatedButton(onPressed: null, child: const Text('評価をお願いします'));
}
