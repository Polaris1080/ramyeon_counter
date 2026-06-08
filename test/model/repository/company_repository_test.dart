import 'package:flutter_test/flutter_test.dart';
import 'package:ramyeon_counter/model/company.dart';
import 'package:ramyeon_counter/model/repository/company_repository.dart';

Future main() async {
  test('CRUD', () async {
    final repository = TestCompanyRepository();
    // Create
    const companyName1 = 'foo';
    final id = await repository.insert(companyName1);
    // Read
    final company1 = await repository.read(id);
    final read = [company1!, (await repository.readByCompany(companyName1))!];
    // Test1(CR)
    for (Company test in read) {
      expect(test.id, id);
      expect(test.company, companyName1);
    }
    // Update
    const companyName2 = 'bar';
    await repository.update(.new(id: id, company: companyName2));
    final company2 = (await repository.read(id))!;
    // Test2(U)
    expect(company2.id, id);
    expect(company2.company, companyName2);
    // Delete
    await repository.delete(id);
    final company3 = (await repository.read(id));
    // Test3(D)
    expect(company3, null);
  });
}
