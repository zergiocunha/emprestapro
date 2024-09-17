import 'package:emprestapro/features/home/home_controller.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void setupDependencies() {
  locator.registerLazySingleton<LoansController>(
    () => LoansController(),
  );
}
