part of 'base/detail_page_action.dart';

class DetailToEditActionViewModel({required int id, required Color? color})
    extends DetailPageActionViewModel {
  /// Transition destination.
  @OneTime()
  String location = '/detail/edit/$id';

  /// Transition data.
  @OneTime()
  Object? extra = color?.toARGB32(); // Color渡しは対応していなかった（はず）
}
