part of './stock_page.dart';

class StockPostit extends StatelessWidget {
  /* Setting */
  static const size = Size.square(150), _padding = 5.0;
  static final _dateFormat = DateFormat('yyyy年MM月dd日');

  const StockPostit({super.key, required this.vm});

  /* Value */
  final StockPostitViewModel vm;

  @override
  Widget build(BuildContext context) {
    return
    /* Postit */
    Container(
      width: size.width,
      height: size.height,
      decoration: BoxDecoration(
        boxShadow: [
          .new(
            color: Colors.grey,
            spreadRadius: 0,
            blurRadius: 3,
            offset: Offset(1, 1),
          ),
        ],
        color: switch (vm.color) {
          Color c => ColorScheme.fromSeed(seedColor: c),
          _ => ColorScheme.of(context),
        }.primaryFixed,
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(_padding),
            /* Content */
            child: Column(
              children: [
                Text(
                  vm.title,
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    fontFamily: "ZenKakuGothicNew",
                  ),
                ),
                Spacer(),
                ...[
                  ('購入日', _dateFormat.format(vm.expirationDate)),
                  ('賞味期限', _dateFormat.format(vm.purchaseDate)),
                  ('価格', '${vm.price}円'),
                ].select((item, _) => term(context, item)),
              ],
            ),
          ),
          ListenableBuilder(
            listenable: vm,
            builder: (context, child) => Visibility(
              visible: vm.isSelectMode,
              /* Check */
              child: Align(
                alignment: Alignment.topRight,
                child: Checkbox(
                  value: vm.selected,
                  onChanged: (value) {
                    vm.selected = !vm.selected;
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget term(BuildContext context, (String, String) item) {
    final heading = item.$1, content = item.$2;
    final tt = Theme.of(context).textTheme,
        painter = TextPainter(
          text: TextSpan(text: "$heading：$content"),
          textDirection: Directionality.of(context),
        )..layout(minWidth: 0, maxWidth: size.width - _padding),
        line = painter.computeLineMetrics().length,
        texts = [
          Text(
            '$heading：',
            textAlign: .start,
            style: tt.labelLarge!.copyWith(color: Colors.black),
          ),
          Text(
            content,
            textAlign: .end,
            style: tt.bodyMedium!.copyWith(
              color: Colors.black,
              fontFamily: "ZenKakuGothicNew",
            ),
          ),
        ];
    return line > 1
        ? Column(crossAxisAlignment: .stretch, children: texts)
        : Row(mainAxisAlignment: .spaceBetween, children: texts);
  }
}
