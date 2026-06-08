import 'view_model/price_range_selecter_vm.dart';
// Package
import 'package:flutter/material.dart';

class PriceRangeSelecter extends StatelessWidget {
  const PriceRangeSelecter(this.vm, {super.key});

  final PriceRangeSelecterViewModel vm;

  @override
  Widget build(BuildContext context) => ListenableBuilder(
    listenable: vm,
    builder: (_, _) => RangeSlider(
      divisions: vm.divisions,
      labels: vm.labels,
      max: vm.maxRange,
      values: vm.priceRange,
      onChanged: vm.priceRangeChanged,
    ),
  );
}
