class ColumnBehind<T> {
  ColumnBehind({
    required T value,
    required this._column,
    Object? Function(bool isDB)? to,
    this.validator,
    this._error,
  }) : _value = value,
       _to = to ?? ((bool? isDB) => value); // 指定なし→そのままの値を返す

  ColumnBehind.rangeValidate({
    required T value,
    required Enum column,
    Object? Function(bool isDB)? to,
    required bool Function()? validator,
    required String supplement,
  }) : this(
         value: value,
         column: column,
         to: to,
         validator: validator,
         error: RangeError.value(
           value as num,
           column.name,
           '${column.name} $supplement',
         ),
       );

  ///
  T get value => _value;
  final T _value;

  ///
  final Enum _column;

  ///
  final Object? Function(bool isDB) _to;

  ///
  final bool Function()? validator;

  ///
  final Error? _error;

  /* Function */
  MapEntry<String, Object?> toEntry(bool isDB) => .new(_column.name, _to(isDB));
  void validate() {
    if (validator != null && validator!.call()) {
      // Validation fail.
      throw _error ?? Error();
    }
  }
}

class PrimaryColumnBehind(int value, Enum column) extends ColumnBehind<int> {
  this
    : super(
        value: value,
        column: column,
        to: (bool isDB) => value >= 0 ? value : null,
      );
}

class OtherPrimaryColumnBehind(int value, Enum column)
    extends ColumnBehind<int> {
  this
    : super.rangeValidate(
        value: value,
        column: column,
        validator: () => value < 0,
        supplement: '>= 0',
      );
}

class NoValidateColumnBehind<T>(T value, Enum column, {super.to})
    extends ColumnBehind<T> {
  this : super(value: value, column: column);
}
