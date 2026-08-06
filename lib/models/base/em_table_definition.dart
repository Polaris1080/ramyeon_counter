extension EmTableDefinition on String {
  // Type
  String get text => '$this TEXT';
  String get integer => '$this INTEGER';
  // Modification
  String get primary => '$this PRIMARY KEY';
  String get notnull => '$this not null';
}
