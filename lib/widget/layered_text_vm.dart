part of 'layered_text.dart';

class LayeredTextViewModel extends ChangeNotifier {
  LayeredTextViewModel(
    BuildContext context, {
    required String title,
    required LayeredTextColor color, // 色（指定）
    int? maxLines,
    double? fontSize, // 文字サイズ
    TextOverflow? overflow, // はみ出した時どうするか（ellipsisだと表示が乱れる）
  }) : assert(overflow != .ellipsis),
       _title = title,
       _maxLines = maxLines,
       _baseColor = switch (color) {
         .primary => ColorScheme.of(context).primaryFixedDim,
         .tertiary => ColorScheme.of(context).tertiaryFixedDim,
       },
       _borderColor = switch (color) {
         .primary => ColorScheme.of(context).primaryContainer,
         .tertiary => ColorScheme.of(context).tertiaryContainer,
       },
       _textStyleBase = TextStyle(
         fontFamily: 'ZenMaruGothic',
         fontSize: fontSize,
         overflow: switch (overflow) {
           .ellipsis => .clip, // 自動変換
           _ => overflow,
         },
       );

  /* Text */
  /// 文字【OneTime】
  String get title => _title;

  /// 列（制限）【OneTime】
  int? get maxLines => _maxLines;

  /* Style */
  /// Stroked text as border.【OneTime】
  TextStyle get borderStyle =>
      _textStyleBase.copyWith(color: _borderColor, fontWeight: .w900);

  /// Solid text as fill.【OneTime】
  TextStyle get baseStyle =>
      _textStyleBase.copyWith(color: _baseColor, fontWeight: .w300);

  final Color _baseColor;
  final Color _borderColor;
  final int? _maxLines;
  final String _title;
  final TextStyle _textStyleBase;
}
