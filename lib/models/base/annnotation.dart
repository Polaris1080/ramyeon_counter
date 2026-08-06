import 'package:meta/meta_meta.dart';

@Target({TargetKind.field})
class PrimaryKey {
  const PrimaryKey();
}

@Target({TargetKind.field})
class OtherPrimary {
  final Type table;

  const OtherPrimary(this.table);
}

@Target({TargetKind.field})
class Relation {
  final Type table;
  final dynamic columu;

  const Relation(this.table, this.columu);
}

@Target({TargetKind.field})
class Constraint {
  final String explanation;

  const Constraint(this.explanation);
}
