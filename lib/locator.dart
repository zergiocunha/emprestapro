import 'package:emprestapro/features/consumer/consumer_controller.dart';
import 'package:emprestapro/features/home/home_controller.dart';
import 'package:emprestapro/features/loan/loan_controller.dart';
import 'package:emprestapro/features/profile/profile_controller.dart';
import 'package:emprestapro/features/sign_in/sign_in_controller.dart';
import 'package:emprestapro/features/sign_up/sign_up_controller.dart';
import 'package:emprestapro/features/splash/splash_controller.dart';
import 'package:emprestapro/features/transaction/transaction_controller.dart';
import 'package:emprestapro/repositories/consumer_repository.dart';
import 'package:emprestapro/repositories/creditor_repository.dart';
import 'package:emprestapro/repositories/loan_repository.dart';
import 'package:emprestapro/repositories/transaction_repository.dart';
import 'package:emprestapro/repositories/user_repository.dart';
import 'package:emprestapro/services/auth_service.dart';
import 'package:emprestapro/services/firestore_service.dart';
import 'package:emprestapro/services/secure_storage.dart';
import 'package:emprestapro/services/storage_service.dart';
import 'package:emprestapro/services/whatsapp_service.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void setupDependencies() {
  locator.registerFactory<AuthService>(
    () => AuthService(),
  );

  locator.registerFactory<SecureStorageService>(
    () => const SecureStorageService(),
  );

  locator.registerFactory<WhatsAppService>(
    () => WhatsAppService(),
  );

  locator.registerFactory<SplashController>(
    () => SplashController(
      secureStorage: locator.get<SecureStorageService>(),
    ),
  );

  locator.registerFactory<StorageService>(
    () => StorageService(),
  );

  locator.registerFactory<FirestoreService>(
    () => FirestoreService(),
  );

  locator.registerFactory<UserRepository>(
    () {
      return UserRepository(
        firestoreService: locator.get<FirestoreService>(),
      );
    },
  );

  locator.registerFactory<ConsumerRepository>(
    () {
      return ConsumerRepository(
        firestoreService: locator.get<FirestoreService>(),
      );
    },
  );

  locator.registerFactory<CreditorRepository>(
    () {
      return CreditorRepository(
        firestoreService: locator.get<FirestoreService>(),
      );
    },
  );

  locator.registerFactory<LoanRepository>(
    () {
      return LoanRepository(
        firestoreService: locator.get<FirestoreService>(),
      );
    },
  );

  locator.registerFactory<TransactionRepository>(
    () {
      return TransactionRepository(
        firestoreService: locator.get<FirestoreService>(),
      );
    },
  );

  locator.registerFactory<ProfileController>(
    () => ProfileController(
      authService: locator.get<AuthService>(),
      secureStorage: locator.get<SecureStorageService>(),
      firestoreService: locator.get<FirestoreService>(),
      storageService: locator.get<StorageService>(),
      creditorRepository: locator.get<CreditorRepository>(),
    ),
  );

  locator.registerFactory<SignUpController>(
    () => SignUpController(
      locator.get<UserRepository>(),
      locator.get<CreditorRepository>(),
      locator.get<AuthService>(),
      locator.get<SecureStorageService>(),
    ),
  );

  locator.registerFactory<SignInController>(
    () => SignInController(
      locator.get<AuthService>(),
      locator.get<SecureStorageService>(),
      locator.get<UserRepository>(),
    ),
  );

  locator.registerLazySingleton<HomeController>(
    () => HomeController(
      secureStorageService: locator.get<SecureStorageService>(),
      creditorRepository: locator.get<CreditorRepository>(),
      loanRepository: locator.get<LoanRepository>(),
      consumerRepository: locator.get<ConsumerRepository>(),
    ),
  );

  locator.registerLazySingleton<LoanController>(
    () => LoanController(
      transactionRepository: locator.get<TransactionRepository>(),
      loanRepository: locator.get<LoanRepository>(),
      creditorRepository: locator.get<CreditorRepository>(),
      consumerRepository: locator.get<ConsumerRepository>(),
      secureStorageService: locator.get<SecureStorageService>(),
      whatsAppService: locator.get<WhatsAppService>(),
      homeController: locator.get<HomeController>(),
    ),
  );

  locator.registerFactory<ConsumerController>(
    () => ConsumerController(
      consumerRepository: locator.get<ConsumerRepository>(),
      loanRepository: locator.get<LoanRepository>(),
      transactionRepository: locator.get<TransactionRepository>(),
    ),
  );

  locator.registerFactory<TransactionController>(
    () => TransactionController(
      transactionRepository: locator.get<TransactionRepository>(),
      loanRepository: locator.get<LoanRepository>(),
    ),
  );
}
