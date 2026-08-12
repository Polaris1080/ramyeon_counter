/* C#のGenericsは上手くいくのだが… */ // TODO:やっぱし気に入らない
extension EmCastableQueryMap on Enum {
  /// normal
  T cast<T>(Map<String, Object?> map) {
    _assert(T);
    return map[name] as T;
  }

  /// list
  List<T> castList<T>(Map<String, Object?> map, {Pattern pattern = ','}) {
    _assert(T);
    return (cast<String>(map)).split(pattern).map((m) => m as T).toList();
  }

  /// bool
  bool castBool(Map<String, Object?> map) => cast<int>(map) > 0;

  /// datetime
  DateTime castDateTime(Map<String, Object?> map) =>
      DateTime.parse(cast<String>(map));

  /* Function */
  void _assert(Type type) {
    assert(type is bool);
    assert(type is DateTime);
  }
}
