import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:todo_list_provider/app/exceptions/auth_exceptions.dart';
import 'package:todo_list_provider/app/repositories/user/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final FirebaseAuth _firebaseAuth;

  UserRepositoryImpl({required FirebaseAuth firebaseAuth})
      : _firebaseAuth = firebaseAuth;

  @override
  Future<User?> register(String email, String password) async {
    try {
      final UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use' ||
          e.code == 'auth/email-already-exists') {
        throw AuthException(message: 'E-mail já cadastrado');
      } else if (e.code == 'invalid-email') {
        throw AuthException(message: 'E-mail inválido fornecido');
      } else if (e.code == 'operation-not-allowed') {
        throw AuthException(message: 'Registro com e-mail desativado');
      } else if (e.code == 'too-many-requests') {
        throw AuthException(
            message: 'Muitas tentativas. Tente novamente mais tarde');
      } else {
        throw AuthException(message: e.message ?? 'Erro ao registrar usuário');
      }
    }
  }

  @override
  Future<User?> login(String email, String password) async {
    try {
      final UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      return userCredential.user;
    } on PlatformException {
      throw AuthException(message: 'Erro ao realizar login');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-login-credentials') {
        throw AuthException(message: 'Usuário ou senha incorretos');
      } else if (e.code == 'invalid-email') {
        throw AuthException(message: 'E-mail inválido');
      } else if (e.code == 'user-disabled') {
        throw AuthException(message: 'Usuário desativado');
      } else if (e.code == 'too-many-requests') {
        throw AuthException(
            message: 'Muitas tentativas. Tente novamente mais tarde');
      } else {
        throw AuthException(message: e.message ?? 'Erro ao realizar login');
      }
    }
  }
}
