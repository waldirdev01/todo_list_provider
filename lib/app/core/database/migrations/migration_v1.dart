import 'package:sqflite_common/sqlite_api.dart';
import 'package:todo_list_provider/app/core/database/migrations/migration.dart';

class MigrationV1 implements Migration {
  @override
  void create(Batch batch) {
    batch.execute('''
      CREATE TABLE todo (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        description varchar(500) not null,
        date DateTime,
        is_done INTEGER
      )
    ''');
  }

  @override
  void update(Batch batch) {
    // TODO: implement update
  }
}
