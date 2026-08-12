class ColumnBehind<T> {
  ColumnBehind({
    required T value,
    required Enum column,
    required Object? Function(bool isDB) to,
    this.validator,
    Error? error,
  }) : _value = value,
       _column = column,
       _to = to,
       _error = error;

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
