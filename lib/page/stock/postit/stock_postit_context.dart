part of 'stock_postit_data.dart';

class StockPostitContext extends RamyeonContextBase {
  Future<List<StockPostitData>> read(int? brandId) async =>
      (await (await db).rawQuery('''
        SELECT s.*,
              r.${RamyeonTableRow.brand.name},
              r.${RamyeonTableRow.packageColor.name}
        FROM ${RamyeonDatabaseTable.stock.name}   as s
        JOIN ${RamyeonDatabaseTable.ramyeon.name} as r 
        ON s.${StockTableRow.brandId.name} = r.${RamyeonTableRow.id.name}
        where s.${StockTableRow.ate.name} = 0
        ${brandId is int ? 'and s.${StockTableRow.brandId.name} = $brandId' : ''};
      '''))
          .select(
            (s, _) => StockPostitData(
              id: s[StockTableRow.id.name] as int,
              brand: s[RamyeonTableRow.brand.name] as String,
              purchaseDate: DateTime.parse(
                s[StockTableRow.purchaseDate.name] as String,
              ),
              expirationDate: DateTime.parse(
                s[StockTableRow.expirationDate.name] as String,
              ),
              price: s[StockTableRow.price.name] as int,
              color: switch (s[RamyeonTableRow.packageColor.name]) {
                int color => Color(color),
                _ => null,
              },
            ),
          )
          .toList();
}
