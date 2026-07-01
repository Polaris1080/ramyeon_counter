part of './stock_page.dart';

class StockPostit extends StatelessWidget {
  static const Size size = .square(150);
  static const double _padding = 5.0;
  static final DateFormat _dateFormat = .new('yyyy年MM月dd日');

  const StockPostit({super.key, required this.vm});

  final StockPostitViewModel vm;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width,
      height: size.height,
      color: vm.color != null
          ? ColorScheme.fromSeed(seedColor: vm.color!).primaryFixed
          : ColorScheme.of(context).primaryFixed,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(_padding),
            child: Column(
              children: [
                Text(vm.title),
                Spacer(),
                term(context, '購入日：', _dateFormat.format(vm.expirationDate)),
                term(context, '賞味期限：', _dateFormat.format(vm.purchaseDate)),
                term(context, '価格：', '${vm.price}円'),
              ],
            ),
          ),
          ListenableBuilder(
            listenable: vm,
            builder: (context, _) {
              return Visibility(
                visible: vm.isSelectMode,
                child: Align(
                  alignment: Alignment.topRight,
                  child: Checkbox(
                    value: vm.selected,
                    onChanged: (value) {
                      vm.selected = !vm.selected;
                    },
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget term(BuildContext context, String heading, String content) {
    final painter = TextPainter(
      text: TextSpan(text: heading + content),
      textDirection: Directionality.of(context),
    )..layout(minWidth: 0, maxWidth: size.width - _padding);
    final line = painter.computeLineMetrics().length;
    return line > 1
        ? Column(
            crossAxisAlignment: .stretch,
            children: [
              const Text('購入日：', textAlign: .start),
              Text(_dateFormat.format(vm.expirationDate), textAlign: .end),
            ],
          )
        : Row(
            mainAxisAlignment: .spaceBetween,
            children: [
              const Text('価格：', textAlign: .start),
              Text('${vm.price}円', textAlign: .end),
            ],
          );
  }
}
