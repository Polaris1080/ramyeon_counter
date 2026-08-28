// Annotation
import 'package:ramyeon_counter/utility/annotations/viewmodel_annotation.dart';

// Package
import 'package:flutter/material.dart';

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

abstract class HomePageActionViewModel extends ChangeNotifier;
