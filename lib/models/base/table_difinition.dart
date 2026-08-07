extension type TColumn(String value) {}
extension type ColumuConstraint(String value) {}

extension t on Enum {
  TColumn get int => TColumn('$name INTEGER');
  TColumn get text => TColumn('$name TEXT');
}

extension t1 on TColumn {
  ColumuConstraint get primary => ColumuConstraint('$value PRIMARY KEY');
  ColumuConstraint get unique => ColumuConstraint('$value UNIQUE');
  ColumuConstraint get notnull => ColumuConstraint('$value NOT NULL');
  ColumuConstraint get nullable => ColumuConstraint('$value ');
}
