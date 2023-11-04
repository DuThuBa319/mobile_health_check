import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import '../common/service/local_manager/local_data_manager.dart';
import '../common/service/navigation/navigation_service.dart';
import 'di.config.dart'; //'filename.conconfig.dart

// đây là file mà khi inject và run "flutter packages pub run build_runner build" thì sẽ cho ra file di.config.dart

GetIt injector = GetIt.instance;
final getIt = GetIt.instance;
@InjectableInit(
  initializerName: r'$initGetIt',
  preferRelativeImports: true,
  asExtension: false,
)
void configureDependencies() {
  $initGetIt(injector);

  // Register the Connectivity instance
  injector.registerLazySingleton<Connectivity>(() => Connectivity());
}

@module
abstract class DioProvider {
  @singleton
  Dio dio() {
    return Dio(
      BaseOptions(
        contentType: "application/json",
        followRedirects: false,
        receiveTimeout: const Duration(seconds:40),
        sendTimeout: const Duration(seconds: 40),
      ),
    );
  }
}

@module
abstract class AppModule {
  @singleton
  Future<LocalDataManager> get localDataManager async =>
      LocalDataManager()..init();

  @singleton
  NavigationService get navigationService => NavigationService();
}
