import 'package:darq/darq.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ramyeon_counter/model/barcode.dart';

const id = 0, brandId = 1, count = 2;
const jam8 = 1234_5678, jam13 = 1234_5678_9012_3;
void main() {
  group('toMap(normal)', () {
    final target1 = Barcode(
      id: id,
      brandId: brandId,
      count: count,
      jam: jam8,
    ).toMap();
    test('id = 0', () => expect(target1['id'], id));
    test('brandId-1', () => expect(target1['brandId'], brandId));
    test('count-1', () => expect(target1['count'], count));
    test('jam-1(8)', () => expect(target1['jam'], jam8));
    final target2 = Barcode(
      id: -1,
      brandId: brandId,
      count: count,
      jam: jam13,
    ).toMap();
    test('id = -1(null)', () => expect(target2['id'], null));
    test('brandId-2', () => expect(target2['brandId'], brandId));
    test('count-2', () => expect(target2['count'], count));
    test('jam-2(13)', () => expect(target2['jam'], jam13));
  });

  group('toMap(error)', () {
    test(
      'brandId < 0',
      () => expect(
        () =>
            Barcode(id: id, brandId: -1, count: count, jam: 1234_5678).toMap(),
        throwsRangeError,
      ),
    );

    test(
      'count < 1',
      () => expect(
        () => Barcode(
          id: id,
          brandId: brandId,
          count: -1,
          jam: 1234_5678,
        ).toMap(),
        throwsRangeError,
      ),
    );

    [1234_567, 1234_5678_9, 1234_5678_9012, 1234_5678_9012_34]
        .select((jam, _) => Barcode(id: 0, brandId: 0, count: 1, jam: jam))
        .forEach(
          (barcode) => test(
            'jam digit is not 8 or 13.',
            () => expect(() => barcode.toMap(), throwsRangeError),
          ),
        );
  });
}
