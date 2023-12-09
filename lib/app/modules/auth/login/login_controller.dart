import 'package:flutter/material.dart';
import 'package:todo_list_provider/app/core/notifier/default_changer_notifier.dart';
import 'package:todo_list_provider/app/exceptions/auth_exceptions.dart';
import 'package:todo_list_provider/app/services/user/user_service.dart';

class LoginController extends DefaultChangNotifier {
  final UserService _userService;
  LoginController({required UserService userService})
      : _userService = userService;

  Future<void> login(String email, String password) async {
    try {
      showloadingAndResetState();
      final user = await _userService.login(email, password);

      if (user != null) {
        success();
      } else {
        setError('Usuário ou senha inválido');
      }
    } on AuthException catch (e) {
      print('Erro: ${e.message}');
      setError(e.message);
    } finally {
      hideLoading();
      notifyListeners();
    }
  }
}
