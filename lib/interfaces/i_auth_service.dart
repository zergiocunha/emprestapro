abstract class IAuthService {
  Future<void> signUpWithEmailPassword(
    String name,
    String email,
    String password,
  );
}
