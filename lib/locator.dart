import 'package:emprestapro/features/home/home_controller.dart';
import 'package:emprestapro/features/sign_in/sign_in_controller.dart';
import 'package:emprestapro/features/sign_up/sign_up_controller.dart';
import 'package:emprestapro/features/splash/splash_controller.dart';
import 'package:emprestapro/services/auth_service.dart';
import 'package:emprestapro/services/firestore_service.dart';
import 'package:emprestapro/services/secure_storage.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void setupDependencies() {
  locator.registerFactory<AuthService>(() => AuthService());

  locator.registerFactory<SecureStorageService>(
      () => const SecureStorageService());

  locator.registerFactory<SplashController>(
    () => SplashController(
      secureStorage: locator.get<SecureStorageService>(),
    ),
  );

  locator.registerFactory<FirestoreService>(() => FirestoreService());

  locator.registerFactory<SignUpController>(() => SignUpController(
        locator.get<FirestoreService>(),
        locator.get<AuthService>(),
        locator.get<SecureStorageService>(),
      ));

  locator.registerFactory<SignInController>(() => SignInController(
        locator.get<FirestoreService>(),
        locator.get<AuthService>(),
        locator.get<SecureStorageService>(),
      ));

  locator.registerLazySingleton<HomeController>(
    () => HomeController(),
  );
}
