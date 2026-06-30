part of './stock_page.dart';

class StockPostit extends StatelessWidget {
  const StockPostit({
    super.key,
    required this.viewModel,
    required this.brand,
    required this.color,
  });

  final StockPostitViewModel viewModel;
  final String brand;
  final int? color;

  static const size = 150;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: 150,
        maxWidth: 150,
        minWidth: 150,
        minHeight: 150,
      ),
      color: Colors.blueGrey,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          children: [
            // brandid
            Text('${brand}'),
            Spacer(),
            Column(
              crossAxisAlignment: .stretch,
              children: [
                const Text('購入日：', textAlign: .start),
                Text(
                  DateFormat(
                    'yyyy年MM月dd日',
                  ).format(viewModel.stock.expirationDate),
                  textAlign: .end,
                ),
              ],
            ),
            Column(
              crossAxisAlignment: .stretch,
              children: [
                const Text('賞味期限：', textAlign: .start),
                Text(
                  DateFormat(
                    'yyyy年MM月dd日',
                  ).format(viewModel.stock.purchaseDate),
                  textAlign: .end,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: .spaceBetween,
              children: [
                const Text('価格：', textAlign: .start),
                Text('${viewModel.stock.price}円', textAlign: .end),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Text text(String data) =>
      Text(data.length > 10 ? data.replaceFirst("：", "：\n") : data);
}
