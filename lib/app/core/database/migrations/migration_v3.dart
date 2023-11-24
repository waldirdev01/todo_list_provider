import 'package:sqflite/sqlite_api.dart';
import 'package:todo_list_provider/app/core/database/migrations/migration.dart';

class MigrationV3 implements Migration {
  @override
  void create(Batch batch) {
    batch.execute('''
      CREATE TABLE teste2 (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
      
      )
    ''');
  }

  @override
  void update(Batch batch) {
    batch.execute('create table teste2(id integer)');
  }
}
