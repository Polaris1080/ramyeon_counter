part of 'layered_text.dart';

class LayeredTextViewModel(
  BuildContext context, {
  required final String _title,
  required LayeredTextColor color,
  final int? _maxLines,
  double? fontSize,
  TextOverflow? overflow,
}) extends ChangeNotifier {
  this : assert(overflow != .ellipsis); //（ellipsisだと表示が乱れる）

  /// Content.
  @OneTime()
  String get title => _title;

  /// Line limit.
  @OneTime()
  int? get maxLines => _maxLines;

  /// Stroked text as border.
  @OneTime()
  TextStyle get borderStyle => _borderStyle;
  final TextStyle _borderStyle = TextStyle(
    color: switch (color) {
      .primary => ColorScheme.of(context).primaryContainer,
      .tertiary => ColorScheme.of(context).tertiaryContainer,
    },
    fontFamily: 'ZenMaruGothic',
    fontSize: fontSize,
    fontWeight: .w900,
    overflow: switch (overflow) {
      .ellipsis => .clip, // 自動変換
      _ => overflow,
    },
  );

  /// Solid text as fill.
  @OneTime()
  TextStyle get baseStyle => _baseStyle;
  final TextStyle _baseStyle = TextStyle(
    color: switch (color) {
      .primary => ColorScheme.of(context).primaryFixedDim,
      .tertiary => ColorScheme.of(context).tertiaryFixedDim,
    },
    fontFamily: 'ZenMaruGothic',
    fontSize: fontSize,
    fontWeight: .w300,
    overflow: switch (overflow) {
      .ellipsis => .clip, // 自動変換
      _ => overflow,
    },
  );
}
