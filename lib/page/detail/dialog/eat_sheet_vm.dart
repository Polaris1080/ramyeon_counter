part of 'eat_sheet.dart';

class EatSheetViewModel({required final RamyeonId _id}) extends ChangeNotifier {
  this {
    evaluation.addListener(evaluationChanged);
  }

  /// [RatingSelecter] rating.
  @OneTime()
  ValueNotifier<int> evaluation = .new(0);
  void evaluationChanged() => notifyListeners();

  /// [EatSheetViewModel] rating (= [RatingSelecter] rating).
  @OneWay()
  int get rating => evaluation.value;

  /// Evaluation selected.
  @OneWay()
  bool get isSelected =>
      RatingWidgetBase.min <= rating && rating <= RatingWidgetBase.max;

  /* Command */
  void consume() {
    RatingRepository().consume(_id, rating);
  }
}
