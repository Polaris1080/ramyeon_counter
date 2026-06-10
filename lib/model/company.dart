import 'base/model_base.dart';
import 'ramyeon.dart';

class Company extends ModelBase {
  /// [Company].id & [Ramyeon].companyId
  /// PrimaryKey (>= 0)
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

  static List<String> get tableDefinition => [
    'id INTEGER PRIMARY KEY',
    'company TEXT not null',
  ];
}
