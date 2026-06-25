part of './stock_page.dart';

class StockPostit extends StatelessWidget {
  const StockPostit({super.key, required this.viewModel});

  final StockPostitViewModel viewModel;

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
      child: Column(
        children: [
          // brandid
          Text('${viewModel.stock.brandId}'),
          Text(
            '購入日：${DateFormat('yyyy年MM月dd日').format(viewModel.stock.purchaseDate)}',
          ),
          Text(
            '賞味期限：${DateFormat('yyyy年MM月dd日').format(viewModel.stock.purchaseDate)}',
          ),
          Text('価格：${viewModel.stock.price}円'),
        ],
      ),
    );
  }
}
