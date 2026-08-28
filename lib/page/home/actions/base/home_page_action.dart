// Annotation
import 'package:ramyeon_counter/utility/annotations/viewmodel_annotation.dart';

// Package
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

// Other
import '../../home_page.dart';

// Partical
part '../catalog_mode_action.dart';
part '../catalog_mode_action_vm.dart';
part '../search_bar_action.dart';
part '../search_bar_action_vm.dart';
part '../sort_list_action.dart';
part '../sort_list_action_vm.dart';

abstract class const HomePageAction({super.key}) extends StatelessWidget;

abstract class HomePageActionViewModel(ColorScheme colorScheme)
    extends ChangeNotifier {
  /// Icon color.
  @OneTime()
  Color color = colorScheme.tertiaryContainer;

  /// Icon tooltip.
  @mustBeOverridden
  String get tooltip;
}
