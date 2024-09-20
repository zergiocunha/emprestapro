import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  AuthService() : _auth = FirebaseAuth.instance;

  final FirebaseAuth _auth;

  Future<User> signUp(String email, String password) async {
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

      throw Exception('Error to sign up');
    } catch (e) {
      throw Exception('AuthService - signUp - Error: $e');
    }
  }

  Future<User> signIn(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = userCredential.user;

      if (user != null) {
        return user;
      }

      throw Exception('Erro ao logar');
    } catch (e) {
      throw Exception('AuthService - signIn - Error: $e');
    }
  }
}
