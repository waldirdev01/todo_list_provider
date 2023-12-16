import 'package:flutter/material.dart';
import 'package:todo_list_provider/app/core/notifier/default_changer_notifier.dart';
import 'package:todo_list_provider/app/exceptions/auth_exceptions.dart';
import 'package:todo_list_provider/app/services/user/user_service.dart';

class LoginController extends DefaultChangNotifier {
  final UserService _userService;
  String? infoMensage;
  LoginController({required UserService userService})
      : _userService = userService;

  bool get hasInfo => infoMensage != null;
  Future<void> loginGoogle() async {
    try {
      showloadingAndResetState();
      infoMensage = null;
      notifyListeners();

      final user = await _userService.googleLogin();
      if (user != null) {
        success();
      } else {
        _userService.logout();
        setError('Erro ao realizar login com o Google');
      }
    } on AuthException catch (e) {
      _userService.logout();

      setError(e.message);
    } catch (e) {
      print(
          "Exceção genérica capturada durante o login com o Google: ${e.toString()}");
      setError(e.toString());
    } finally {
      hideLoading();
      notifyListeners();
      print("Processo de login com o Google finalizado.");
    }
  }

  Future<void> login(String email, String password) async {
    try {
      showloadingAndResetState();
      infoMensage = null;
      final user = await _userService.login(email, password);

      if (user != null) {
        success();
      } else {
        setError('Usuário ou senha inválido');
      }
    } on AuthException catch (e) {
      setError(e.message);
    } finally {
      hideLoading();
      notifyListeners();
    }
  }

  void forgotPassword(String email) async {
    try {
      showloadingAndResetState();
      infoMensage = null;
      await _userService.forgotPassword(email);
      infoMensage = 'E-mail enviado para $email';
    } on AuthException catch (e) {
      setError(e.message);
    } finally {
      hideLoading();
      notifyListeners();
    }
  }
}
