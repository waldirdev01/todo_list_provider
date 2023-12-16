import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:synchronized/synchronized.dart';
import 'package:todo_list_provider/app/core/database/sqlite_migration_factory.dart';

class SqliteConnectionFactory {
  // ignore: constant_identifier_names
  static const _VERSION = 1;
  // ignore: constant_identifier_names
  static const _DATABASE_NAME = 'TODO_LIST_PROVIDER';
  static SqliteConnectionFactory? _instance;
  final _lock = Lock();
  Database? _db;
  SqliteConnectionFactory._();

  factory SqliteConnectionFactory() {
    _instance ??= SqliteConnectionFactory._();
    return _instance!;
  }

  Future<Database> openConnection() async {
    var databasePath = await getDatabasesPath();
    var databasePathFinal = join(databasePath, _DATABASE_NAME);
    if (_db == null) {
      await _lock.synchronized(() async {
        _db ??= await openDatabase(databasePathFinal,
            version: _VERSION,
            onConfigure: _onConfigure,
            onCreate: _onCreate,
            onUpgrade: _onUpgrade,
            onDowngrade: _onDaownGrade);
      });
    }
    {
      return _db!;
    }
  }

  void closeConnection() {
    _db?.close();
    _db = null;
  }

  Future<void> _onConfigure(Database db) async {
    await db.execute('PRAGMA foreign_keys = ON');
  }

  Future<void> _onCreate(Database db, int version) async {
    var batch = db.batch();
    var migrations = SqliteMigrationFactory().geCreatetMigrations();
    for (var migration in migrations) {
      migration.create(batch);
    }
    batch.commit();
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int version) async {
    var batch = db.batch();
    var migrations = SqliteMigrationFactory().geUpdateMigrations(oldVersion);
    for (var migration in migrations) {
      migration.update(batch);
    }
    batch.commit();
  }

  Future<void> _onDaownGrade(Database db, int oldVersion, int version) async {}
}
