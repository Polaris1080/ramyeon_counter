// Annotation
import 'package:ramyeon_counter/utility/annotations/viewmodel_annotation.dart';

// Package
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// Partical
part '../detail_to_edit_action.dart';
part '../detail_to_edit_action_vm.dart';

abstract class const DetailPageAction({super.key}) extends StatelessWidget;

abstract class DetailPageActionViewModel extends ChangeNotifier;
