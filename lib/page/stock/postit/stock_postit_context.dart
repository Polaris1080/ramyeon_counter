part of '../stock_page.dart';

class StockPostitContext extends RamyeonContextBase {
  Future<List<StockPostitData>> readAll() async {
    return (await (await db).rawQuery('''
      SELECT s.*,
             r.${RamyeonTableRow.brand.name},
             r.${RamyeonTableRow.packageColor.name}
      FROM stock as s JOIN ramyeon as r 
      ON s.${StockTableRow.brandId.name} = r.${RamyeonTableRow.id.name}
      where s.${StockTableRow.ate.name} = 0;
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
              int c => Color(c),
              _ => null,
            },
          ),
        )
        .toList();
  }
}
