import 'package:meta/meta_meta.dart';

@Target({TargetKind.field})
class PrimaryKey {
  const PrimaryKey();
}

@Target({TargetKind.field})
class OtherPrimary {
  final Type key;

  const OtherPrimary(this.key);
}
