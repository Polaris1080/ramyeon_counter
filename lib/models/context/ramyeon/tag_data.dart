// Base
import '../../base/model_base.dart';

class TagData({
  /// タグ
  required final String tag,

  /// 順位
  required final int rank,

  /// 個数
  required final int count,
}) extends VirtualModelBase;
