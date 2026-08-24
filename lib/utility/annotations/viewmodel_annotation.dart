// Package
import 'package:meta/meta_meta.dart';

/// Widget <-> ViewModel
@Target({TargetKind.field, TargetKind.getter})
class const TwoWay();

/// Widget <-- ViewModel
@Target({TargetKind.field, TargetKind.getter})
class const OneWay();

/// Widget --> ViewModel
@Target({TargetKind.field, TargetKind.setter})
class const OneWayToSource();

/// Widget --- ViewModel
@Target({TargetKind.field, TargetKind.getter})
class const OneTime();
