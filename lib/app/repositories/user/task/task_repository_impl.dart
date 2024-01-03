import '../../../core/database/sqlite_connection_factory.dart';
import 'task_repository.dart';

class TaskRpositoryImpl implements TaskRepository {
  final SqliteConnectionFactory _connectionFactory;

  TaskRpositoryImpl({required SqliteConnectionFactory connectionFactory})
      : _connectionFactory = connectionFactory;
  @override
  Future<void> save(DateTime date, String description) async {
    final connection = await _connectionFactory.openConnection();
    await connection.insert('todo', {
      'id': null,
      'description': description,
      'date': date.toIso8601String(),
      'is_done': 0,
    });
  }
}
