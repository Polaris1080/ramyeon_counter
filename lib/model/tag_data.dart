import 'base/model_base.dart';

class TagData extends VirtualModelBase {
  /// タグ
  final String tag;

  /// 順位
  final int rank;

  /// 個数
  final int count;

  TagData({required this.tag, required this.rank, required this.count});

  @override
  Map<String, Object?> toMap({bool isDB = false}) {
    return <String, Object?>{
      // Text(String)
      'tag': tag,
      // INTEGER(int)
      'rank': rank,
      // INTEGER(int)
      'count': count,
    };
  }
}
