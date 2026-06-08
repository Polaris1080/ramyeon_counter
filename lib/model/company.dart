import 'base/i_mapperble.dart';
import 'ramyeon.dart';

class Company implements IMapperble {
  /// [Company].id & [Ramyeon].companyId
  final int id;

  /// 会社
  final String company;

  Company({required this.id, required this.company});

  @override
  Map<String, Object?> toMap({bool isDB = false}) => {
    // INTEGER(int)PrimaryKey
    'id': id >= 0 ? id : null,
    // TEXT(String)
    'company': company,
  };

  @override
  String toString() =>
      'Ramyeon{'
      'id: $id, '
      'company: $company'
      '}';

  static List<String> get tableDefinition => [
    'id INTEGER PRIMARY KEY',
    'company TEXT not null',
  ];
}
