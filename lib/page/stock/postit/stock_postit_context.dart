part of 'stock_postit_data.dart';

class StockPostitContext extends RamyeonContextBase {
  Future<List<StockPostitData>> read(int? brandId) async =>
      (await (await db).rawQuery('''
        SELECT s.*,
               r.${RamyeonTableColumns.brand.name},
               r.${RamyeonTableColumns.packageColor.name}
        FROM ${RamyeonDatabaseTables.stock.name}   as s
        JOIN ${RamyeonDatabaseTables.ramyeon.name} as r 
        ON    s.${StockTableColumns.brandId.name} = r.${RamyeonTableColumns.id.name}
        where s.${StockTableColumns.ate.name} = 0
        ${brandId is int ? 'and s.${StockTableColumns.brandId.name} = $brandId' : ''};
      '''))
          .select(
            (s, _) => StockPostitData(
              id: s[StockTableColumns.id.name] as int,
              brand: s[RamyeonTableColumns.brand.name] as String,
              purchaseDate: DateTime.parse(
                s[StockTableColumns.purchaseDate.name] as String,
              ),
              expirationDate: DateTime.parse(
                s[StockTableColumns.expirationDate.name] as String,
              ),
              price: s[StockTableColumns.price.name] as int,
              color: switch (s[RamyeonTableColumns.packageColor.name]) {
                int color => Color(color),
                _ => null,
              },
            ),
          )
          .toList();
}
