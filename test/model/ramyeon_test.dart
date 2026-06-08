import 'package:flutter_test/flutter_test.dart';
import 'package:ramyeon_counter/model/ramyeon.dart';

const id = 0, companyId = 1, brand = 'foo_bar', company = 'hoge';
const tag = ['foo', 'bar'];

void main() {
  group('toMap(normal)', () {
    final target1 = Ramyeon(
      id: id,
      companyId: companyId,
      brand: brand,
      company: company,
      tag: tag,
    ).toMap(isDB: true);
    test('id = 0', () => expect(target1['id'], id));
    test('companyId-1', () => expect(target1['companyId'], companyId));
    test('brand-1', () => expect(target1['brand'], brand));
    test('tag-1(List<String>)', () => expect(target1['tag'], tag.join(',')));

    final target2 = Ramyeon(
      id: -1,
      companyId: companyId,
      brand: brand,
      company: company,
      tag: tag,
    ).toMap();
    test('id = -1(null)', () => expect(target2['id'], null));
    test('companyId-2', () => expect(target2['companyId'], companyId));
    test('brand-2', () => expect(target2['brand'], brand));
    test('tag-2(String)', () => expect(target2['tag'], tag));
  });
}
