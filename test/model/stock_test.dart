import 'package:flutter_test/flutter_test.dart';
import 'package:ramyeon_counter/model/stock.dart';

const id = 0, brandId = 1, price = 99;

void main() {
  group('toMap(normal)', () {
    final date = DateTime.now();

    final target1 = Stock(
      id: id,
      brandId: brandId,
      purchaseDate: date,
      expirationDate: date,
      price: price,
    ).toMap(isDB: true);
    test('id = 0', () => expect(target1['id'], id));
    test('brandId-1', () => expect(target1['brandId'], brandId));
    test(
      'purchaseDate-1',
      () => expect(target1['purchaseDate'], date.toString()),
    );
    test(
      'expirationDate-1',
      () => expect(target1['expirationDate'], date.toString()),
    );
    test('price-1', () => expect(target1['price'], price));
    test('ate-1', () => expect(target1['ate'], 0));

    final target2 = Stock(
      id: -1,
      brandId: brandId,
      purchaseDate: date,
      expirationDate: date,
      price: price,
      ate: true,
    ).toMap();
    test('id = -1(null)', () => expect(target2['id'], null));
    test('brandId-2', () => expect(target2['brandId'], brandId));
    test('purchaseDate-2', () => expect(target2['purchaseDate'], date));
    test('expirationDate-2', () => expect(target2['expirationDate'], date));
    test('price-2', () => expect(target2['price'], price));
    test('ate-2', () => expect(target2['ate'], true));
  });

  group('toMap(error)', () {
    final date = DateTime.now();
    test(
      'brandId < 0',
      () => expect(
        () => Stock(
          id: id,
          brandId: -1,
          purchaseDate: date,
          expirationDate: date,
          price: price,
        ).toMap(),
        throwsRangeError,
      ),
    );

    test(
      'price < 0',
      () => expect(
        () => Stock(
          id: id,
          brandId: brandId,
          purchaseDate: date,
          expirationDate: date,
          price: -1,
        ).toMap(),
        throwsRangeError,
      ),
    );
  });
}
