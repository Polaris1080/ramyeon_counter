import 'package:flutter_test/flutter_test.dart';
import 'package:ramyeon_counter/model/company.dart';

const company = 'foo_bar';

void main() {
  group('toMap(normal)', () {
    final target1 = Company(id: 0, company: company).toMap();
    final target2 = Company(id: -1, company: company).toMap();
    test('id = 0', () => expect(target1['id'], 0));
    test('company-1', () => expect(target1['company'], company));
    test('id = -1(null)', () => expect(target2['id'], null));
    test('company-2', () => expect(target2['company'], company));
  });
}
