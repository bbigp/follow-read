

import 'package:drift/drift.dart';


class ConfTable extends Table {

  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().named('name')
      .withDefault(const Constant(""))();
  TextColumn get value => text().named('value')
      .withDefault(const Constant(""))();
  Int64Column get userId => int64().named('user_id')();


  List<Index> get indexes => [
    Index('unique_userid_name', 'UNIQUE(user_id, name)')
  ];

  @override
  String? get tableName => "conf";

}

// extension ConfEntityConversion on ConfEntity {
//   Conf toModel() {
//     return Conf(
//       name: name,
//       value: value,
//       userId: userId.toInt(),
//     );
//   }
// }


