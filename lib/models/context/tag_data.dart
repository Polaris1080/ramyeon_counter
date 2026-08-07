// Base
import '../base/model_base.dart';

class TagData extends VirtualModelBase {
  TagData({required this.tag, required this.rank, required this.count});

  /// タグ
  final String tag;

  /// 順位
  final int rank;

  /// 個数
  final int count;
}
