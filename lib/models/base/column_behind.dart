class ColumnBehind<T> {
  ColumnBehind({
    required T value,
    required Enum column,
    Object? Function(bool isDB)? to,
    this.validator,
    Error? error,
  }) : _value = value,
       _column = column,
       _to = to ?? ((bool? isDB) => value), // 指定なし→そのままの値を返す
       _error = error;

  ColumnBehind.noValidate(
    T value,
    Enum column, {
    Object? Function(bool isDB)? to,
  }) : this(value: value, column: column, to: to);

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

class PrimaryColumnBehind extends ColumnBehind<int> {
  PrimaryColumnBehind(int value, Enum column)
    : super(
        value: value,
        column: column,
        to: (bool isDB) => value >= 0 ? value : null,
      );
}

class OtherPrimaryColumnBehind extends ColumnBehind<int> {
  OtherPrimaryColumnBehind(int value, Enum column)
    : super.rangeValidate(
        value: value,
        column: column,
        validator: () => value < 0,
        supplement: '>= 0',
      );
}
