import 'dart:io';
import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
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
    } on FirebaseAuthException catch (e) {
      // Tratamento específico para erros do FirebaseAuth
      switch (e.code) {
        case 'invalid-login-credentials':
          throw AuthException(message: 'Usuário ou senha incorretos');
        case 'invalid-email':
          throw AuthException(message: 'E-mail inválido');
        case 'user-disabled':
          throw AuthException(message: 'Usuário desativado');
        case 'too-many-requests':
          throw AuthException(
              message: 'Muitas tentativas. Tente novamente mais tarde');
        case 'account-exists-with-different-credential':
          throw AuthException(
              message: 'E-mail cadastrado com outro método de login');
        default:
          throw AuthException(message: e.message ?? 'Erro ao realizar login');
      }
    } on PlatformException catch (e) {
      // Tratamento para outras exceções de plataforma
      throw AuthException(message: e.message ?? 'Erro na plataforma');
    }
  }

  @override
  Future<void> forgotPassword(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
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
      } else if (e.code == 'account-exists-with-different-credential') {
        throw AuthException(
            message:
                'O e-mail já foi cadastrado através de outro método de login, como Google');
      } else {
        throw AuthException(message: e.message ?? 'Erro ao realizar login');
      }
    }
  }

  @override
  Future<User?> googleLogin() async {
    try {
      final googleSignIn = GoogleSignIn();
      final userGoogle = await googleSignIn.signIn();
      if (userGoogle != null) {
        final logingMethods =
            await _firebaseAuth.fetchSignInMethodsForEmail(userGoogle.email);
        if (logingMethods.contains('password')) {
          throw AuthException(
              message:
                  'Conta cadastrada com e-mail e senha. Faça login com e-mail e senha');
        }
      } else {
        final googleAuth = await userGoogle!.authentication;
        final firebaseCredential = GoogleAuthProvider.credential(
            idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);
        var userCredential =
            await _firebaseAuth.signInWithCredential(firebaseCredential);
        return userCredential.user;
      }
    } on FirebaseAuthException catch (e, s) {
      print(e);
      print(s);
      if (e.code == 'account-exists-with-different-credential') {
        throw AuthException(
            message:
                'Conta já cadastrada com outro método. Faça login com o mesmo método');
      } else if (e.code == 'invalid-credential') {
        throw AuthException(message: 'Credencial inválida');
      } else {
        throw AuthException(message: e.message ?? 'Erro ao realizar login');
      }
    }
  }

  @override
  Future<void> logout() async {
    await GoogleSignIn().signOut();
    _firebaseAuth.signOut();
  }
}
