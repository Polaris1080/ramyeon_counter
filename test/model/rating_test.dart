import 'package:flutter_test/flutter_test.dart';
import 'package:ramyeon_counter/model/rating.dart';

const id = 0, brandId = 1, rating = 2;

void main() {
  group('toMap(normal)', () {
    final date = DateTime.now();

    final target1 = Rating(
      id: id,
      brandId: brandId,
      rating: rating,
      date: date,
    ).toMap(isDB: true);
    test('id = 0', () => expect(target1['id'], id));
    test('brandId-1', () => expect(target1['brandId'], brandId));
    test('count-1', () => expect(target1['rating'], rating));
    test('jam-1(String)', () => expect(target1['date'], date.toString()));

    final target2 = Rating(
      id: -1,
      brandId: brandId,
      rating: rating,
      date: date,
    ).toMap();
    test('id = -1(null)', () => expect(target2['id'], null));
    test('brandId-2', () => expect(target2['brandId'], brandId));
    test('count-2', () => expect(target2['rating'], rating));
    test('jam-2(DateTime)', () => expect(target2['date'], date));
  });

  group('toMap(error)', () {
    final date = DateTime.now();

    test(
      'brandId < 0',
      () => expect(
        () => Rating(id: id, brandId: -1, rating: rating, date: date).toMap(),
        throwsRangeError,
      ),
    );

    test(
      'count < 1',
      () => expect(
        () => Rating(id: id, brandId: brandId, rating: 0, date: date).toMap(),
        throwsRangeError,
      ),
    );

    test(
      '10 < count',
      () => expect(
        () => Rating(id: id, brandId: brandId, rating: 11, date: date).toMap(),
        throwsRangeError,
      ),
    );
  });
}
