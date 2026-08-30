// Annotation
import 'package:ramyeon_counter/utility/annotations/viewmodel_annotation.dart';

// Package
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:meta/meta.dart';

// Partical
part '../detail_to_edit_action.dart';
part '../detail_to_edit_action_vm.dart';

abstract class const DetailPageAction({super.key}) extends StatelessWidget;

abstract class DetailPageActionViewModel extends ChangeNotifier {
  /// Icon tooltip.
  @mustBeOverridden
  String get tooltip;
}
