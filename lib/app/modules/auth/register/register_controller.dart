import 'package:flutter/material.dart';
import 'package:todo_list_provider/app/core/notifier/default_changer_notifier.dart';
import 'package:todo_list_provider/app/exceptions/auth_exceptions.dart';
import 'package:todo_list_provider/app/services/user/user_service.dart';

class RegisterController extends DefaultChangNotifier {
  final UserService _userService;

  RegisterController({required UserService userService})
      : _userService = userService;

  Future<void> registerUser(String email, String password) async {
    try {
      showloadingAndResetState();
      notifyListeners();
      final user = await _userService.register(email, password);
      if (user != null) {
        success();
      } else {
        setError('Erro ao registrar usuário');
      }
    } on AuthException catch (e) {
      setError(e.message ?? 'Erro ao registrar usuário');
    } finally {
      hideLoading();
      notifyListeners();
    }
  }
}
