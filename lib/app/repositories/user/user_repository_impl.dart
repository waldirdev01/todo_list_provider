import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_list_provider/app/exceptions/auth_exceptions.dart';
import 'package:todo_list_provider/app/repositories/user/user_repository.dart';

class UserRepositoryImplements implements UserRepository {
  final FirebaseAuth _firebaseAuth;

  UserRepositoryImplements({required FirebaseAuth firebaseAuth})
      : _firebaseAuth = firebaseAuth;
  @override
  Future<User?> register(String email, String password) async {
    try {
      final UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-exists' ||
          e.code == 'auth/email-already-exists') {
        final loginTypes =
            await _firebaseAuth.fetchSignInMethodsForEmail(email);
        if (loginTypes.contains('password')) {
          throw AuthException(message: 'E-mail já cadastrado');
        } else {
          throw AuthException(message: 'E-mail já cadastrado com o Google');
        }
      } else if (e.code == 'invalid-email' || e.code == 'auth/invalid-email') {
        throw AuthException(message: 'E-mail inválido fornecido');
      } else if (e.code == 'operation-not-allowed' ||
          e.code == 'auth/operation-not-allowed') {
        throw AuthException(message: 'Registro com e-mail desativado');
      } else if (e.code == 'too-many-requests' ||
          e.code == 'auth/too-many-requests') {
        throw AuthException(
            message: 'Muitas tentativas. Tente novamente mais tarde');
      } else {
        throw AuthException(message: e.message ?? 'Erro ao registrar usuário');
      }
    }
  }
}
