part of '../stock_page.dart';

class StockPostit extends StatelessWidget {
  /* Setting */
  static const size = Size.square(150), _postitContentPadding = 5.0;

  const StockPostit({
    super.key,
    required this.isSelectMode,
    required this.isSelected,
    required this.data,
  });

  /* Argument */
  final ValueNotifier<bool> isSelectMode;
  final ValueNotifier<bool> isSelected;
  final StockPostitData data;

  @override
  Widget build(BuildContext context) {
    /* Postit */
    return Container(
      width: StockPostit.size.width,
      height: StockPostit.size.height,
      decoration: BoxDecoration(
        boxShadow: [
          .new(
            color: Colors.grey,
            spreadRadius: 0,
            blurRadius: 3,
            offset: Offset(1, 1),
          ),
        ],
        color: switch (data.color) {
          Color color => ColorScheme.fromSeed(seedColor: color),
          _ => ColorScheme.of(context),
        }.primaryFixed,
      ),
      child: Stack(children: [_content(context), _checkBox]),
    );
  }

  /* Widget */
  Widget _content(BuildContext context) {
    const header = ['購入日', '賞味期限', '価格'];
    final tt = Theme.of(context).textTheme, df = DateFormat('yyyy年MM月dd日');
    List<Text> term(String heading, String content) {
      return [
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
    }

    return Padding(
      padding: const EdgeInsets.all(_postitContentPadding),
      child: Column(
        children: [
          /* title */
          Text(
            data.brand,
            style: tt.titleSmall!.copyWith(fontFamily: "ZenKakuGothicNew"),
          ),
          Spacer(),
          /* term */
          ...header.zip(
            [
              df.format(data.expirationDate),
              df.format(data.purchaseDate),
              '${data.price}円',
            ],
            (heading, content) {
              /* rayout */
              final painter =
                  TextPainter(
                    text: TextSpan(text: "$heading：$content"),
                    textDirection: Directionality.of(context),
                  )..layout(
                    minWidth: 0,
                    maxWidth: size.width - _postitContentPadding * 2,
                  );
              return painter.computeLineMetrics().length > 1
                  ? Column(
                      crossAxisAlignment: .stretch,
                      children: term(heading, content),
                    )
                  : Row(
                      mainAxisAlignment: .spaceBetween,
                      children: term(heading, content),
                    );
            },
          ),
        ],
      ),
    );
  }

  Widget get _checkBox => ValueListenableBuilder(
    valueListenable: isSelectMode,
    builder: (_, flag, w) => Visibility(visible: flag, child: w!),
    child: Align(
      alignment: Alignment.topRight,
      child: ValueListenableBuilder(
        valueListenable: isSelected,
        builder: (_, flag, _) => Checkbox(
          // Color
          checkColor: Colors.green[700],
          fillColor: WidgetStateColor.resolveWith((_) => Colors.white),
          side: WidgetStateBorderSide.resolveWith(
            (_) => BorderSide(width: 2.0, color: Colors.black87),
          ),
          // Other
          value: flag,
          onChanged: (_) => isSelected.flip(),
        ),
      ),
    ),
  );
}
