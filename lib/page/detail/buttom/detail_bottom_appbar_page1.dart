part of 'detail_bottom_appbar.dart';

class PageOne extends StatelessWidget {
  /* Setting */
  static const _spacing = 10.0;

  const PageOne({
    super.key,
    required this.ramyeonId,
    required this.packageColor,
  });

  final int ramyeonId;
  final Color? packageColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(_spacing),
      child: Wrap(
        alignment: .spaceEvenly,
        spacing: _spacing,
        runSpacing: _spacing,
        children: [
          /* History_Rating */
          FutureBuilder(
            future: RatingRepository().countByBrandId(ramyeonId),
            builder: (context, snapshot) => ElevatedButton.icon(
              icon: const Icon(Icons.star),
              label: const Text('評価'),
              onPressed: switch (snapshot.data) {
                int count when count > 0 => () {
                  context.push(
                    '/detail/rating/$ramyeonId',
                    extra: packageColor,
                  );
                },
                _ => null,
              },
            ),
            initialData: 0,
          ),
          /* History_Price */
          FutureBuilder(
            future: StockRepository().countByBrandId(ramyeonId),
            builder: (context, snapshot) => ElevatedButton.icon(
              icon: const Icon(Icons.currency_yen),
              label: const Text('価格'),
              onPressed: switch (snapshot.data) {
                int count when count > 0 => () {
                  context.push('/detail/price/$ramyeonId', extra: packageColor);
                },
                _ => null,
              },
            ),
            initialData: 0,
          ),
          ElevatedButton.icon(
            icon: Icon(Icons.favorite),
            label: const Text('在庫'),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
