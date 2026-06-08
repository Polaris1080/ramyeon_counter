extension EmDatetime on DateTime {
  bool isBeforeAndSame(DateTime other) =>
      isAtSameMomentAs(other) || isBefore(other);

  bool isAfterAndSame(DateTime other) =>
      isAtSameMomentAs(other) || isAfter(other);
}
