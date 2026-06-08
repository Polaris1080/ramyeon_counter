import '../rating_widget_base.dart';
import 'rating_range_selecter_vm.dart';
import 'package:darq/darq.dart';
import 'package:flutter/material.dart';

class RatingRangeSelecter extends RatingSelecterBase {
  const RatingRangeSelecter(this.vm, {super.key});

  final RatingRangeSelecterViewModel vm;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        for (int row in RangeIterable(0, items ~/ _perRow))
          Wrap(
            children: [
              for (int rate
                  in RatingSelecterBase.range.skip(_perRow * row).take(_perRow))
                ListenableBuilder(
                  listenable: vm,
                  builder: (context, _) {
                    return IconButton(
                      icon: vm.min <= rate && rate <= vm.max
                          ? RatingWidgetBase.fullStar
                          : RatingWidgetBase.noneStar,
                      onPressed: () => vm.ratingChanged(rate),
                      constraints: const BoxConstraints(),
                      padding: RatingSelecterBase.iconPadding,
                    );
                  },
                ),
            ],
          ),
      ],
    );
  }

  static const items = RatingWidgetBase.items,
      _perRow = RatingWidgetBase.perRow;
}
