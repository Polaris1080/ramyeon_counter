part of '../stock_page.dart';

class StockPostit extends StatelessWidget {
  /* Setting */
  static const size = Size.square(150), _postitContentPadding = 5.0;

  StockPostit({
    super.key,
    required this.isSelectMode,
    required this.isSelected,
    required StockPostitData data,
  }) : _postitColor = data.color,
       _titleText = data.brand,
       _termTexts = ['購入日', '賞味期限', '価格'].zip([
         DateFormat('yyyy年MM月dd日').format(data.expirationDate),
         DateFormat('yyyy年MM月dd日').format(data.purchaseDate),
         '${data.price}円',
       ], (a, b) => (heading: a, content: b)).toList();

  /* Argument */
  final ValueNotifier<bool> isSelectMode;
  final ValueNotifier<bool> isSelected;

  /* Value */
  final Color? _postitColor;
  final String _titleText;
  final List<({String heading, String content})> _termTexts;

  @override
  Widget build(BuildContext context) {
    return postit(
      context,
      color: _postitColor,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(_postitContentPadding),
            child: Column(
              children: [
                /* title */
                Text(
                  _titleText,
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    fontFamily: "ZenKakuGothicNew",
                  ),
                ),
                Spacer(),
                ..._termTexts.select((s, _) => term(context, s)),
              ],
            ),
          ),
          ValueListenableBuilder(
            valueListenable: isSelectMode,
            builder: (_, f, child) => Visibility(visible: f, child: child!),
            child: Align(
              alignment: Alignment.topRight,
              child: ValueListenableBuilder(
                valueListenable: isSelected,
                builder: (context, f, _) =>
                    /* check */
                    Checkbox(value: f, onChanged: (_) => isSelected.flip()),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /* Widget */
  Container postit(BuildContext context, {Color? color, Widget? child}) {
    final BoxShadow shadow = .new(
      color: Colors.grey,
      spreadRadius: 0,
      blurRadius: 3,
      offset: Offset(1, 1),
    );

    return Container(
      width: size.width,
      height: size.height,
      decoration: BoxDecoration(
        boxShadow: [shadow],
        color: switch (color) {
          Color color => ColorScheme.fromSeed(seedColor: color),
          _ => ColorScheme.of(context),
        }.primaryFixed,
      ),
      child: child,
    );
  }

  /// 中身
  Widget term(BuildContext context, ({String heading, String content}) item) {
    final (:heading, :content) = item;
    final List<Text> texts = [
      Text(
        '$heading：',
        textAlign: .start,
        style: Theme.of(
          context,
        ).textTheme.labelLarge!.copyWith(color: Colors.black),
      ),
      Text(
        content,
        textAlign: .end,
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
          color: Colors.black,
          fontFamily: "ZenKakuGothicNew",
        ),
      ),
    ];
    final painter = TextPainter(
      text: TextSpan(text: "$heading：$content"),
      textDirection: Directionality.of(context),
    )..layout(minWidth: 0, maxWidth: size.width - _postitContentPadding * 2);

    return painter.computeLineMetrics().length > 1
        ? Column(crossAxisAlignment: .stretch, children: texts)
        : Row(mainAxisAlignment: .spaceBetween, children: texts);
  }
}
