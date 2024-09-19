import 'package:emprestapro/interfaces/i_auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService extends IAuthService {
  AuthService() : _auth = FirebaseAuth.instance;

  final FirebaseAuth _auth;

  @override
  Future<User> signUpWithEmailPassword(
      String name, String email, String password) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = userCredential.user;

      if (user != null) {
        return user;
      }

      throw Exception('Erro ao registrar usuário no Auth');
    } catch (e) {
      throw Exception('Erro ao registrar usuário no Auth: $e');
    }
  }
}
