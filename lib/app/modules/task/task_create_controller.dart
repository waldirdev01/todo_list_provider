import 'package:todo_list_provider/app/core/notifier/default_changer_notifier.dart';
import 'package:todo_list_provider/app/services/user/task/task_service.dart';

class TaskCreateController extends DefaultChangNotifier {
  final TaskService _taskService;
  DateTime? _selectedDate;
  TaskCreateController({required TaskService taskService})
      : _taskService = taskService;
  set selectedDate(DateTime? selectesDate) {
    resetState();
    _selectedDate = selectesDate;
    notifyListeners();
  }

  DateTime? get selectedDate => _selectedDate;

  save(String description) async {
    try {
      showLoading();
      notifyListeners();
      if (selectedDate != null) {
        await _taskService.save(selectedDate!, description);
        success();
      } else {
        setError('  Selecione uma data para a tarefa');
      }
    } catch (e, s) {
      print(s);
      print(e);
      setError('Erro ao salvar tarefa');
    } finally {
      hideLoading();
      notifyListeners();
    }
  }
}
