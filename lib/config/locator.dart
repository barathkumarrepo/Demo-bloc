
import 'package:get_it/get_it.dart';
import '../services/repositories/home_repo.dart';
import '../utils/permission_handler.dart';
import '../utils/secure_storage.dart';

final locator = GetIt.instance;

void setupLocator() async {
  //not using locator.registerLazySingleton(() => NavigationService.getInstance());
  locator.registerLazySingleton(() => SecureStorage.getInstance());
  locator.registerLazySingleton(() => PermissionHandler.getInstance());

  //repositories
  locator.registerFactory(() => HomeRepository());

  // final SharedPrefs sharedPrefs = await SharedPrefs.getInstance();
  // locator.registerSingleton(sharedPrefs);
}
