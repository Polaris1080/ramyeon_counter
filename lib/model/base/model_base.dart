import 'package:darq/darq.dart';

/// Model 'not' exist table
abstract class VirtualModelBase {
  Map<String, Object?> toMap({bool isDB = false});

  @override
  String toString() =>
      '$runtimeType{${toMap().entries.select((e, _) => '${e.key}: ${e.value}').join(', ')}}';
}

/// Model exist table
abstract class ModelBase extends VirtualModelBase {
  static List<String> get tableDefinition => [];
}
