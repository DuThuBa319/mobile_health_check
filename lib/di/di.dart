import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import '../common/service/local_manager/local_data_manager.dart';
import '../common/service/navigation/navigation_service.dart';
import 'di.config.dart'; //'filename.conconfig.dart

// đây là file mà khi inject và run "flutter packages pub run build_runner build" thì sẽ cho ra file di.config.dart

//! Set up service locator (Dependency Injection)
//! Đây là nơi đăng ký tất cả các types mà muốn sử dụng, truy cập bất cứ lúc nào trong ứng dụng => DI
//! Dòng đầu tiên dưới đây bắt buộc phải có
GetIt injector = GetIt.instance;
final getIt = GetIt.instance;
@InjectableInit(
  initializerName: r'$initGetIt',
  preferRelativeImports: true,
  asExtension: false,
)

//! Set up service locator (Dependency Injection)
void configureDependencies() {
  //? Đăng ký tất cả dependency trong đây
  $initGetIt(injector);
  // Register the Connectivity instance
  injector.registerLazySingleton<Connectivity>(() => Connectivity());
}

/* @module là 1 annotation của injectable,
   => đánh dấu abstract class sau là một module, nơi đăng ký các dependencies */
@module
abstract class DioProvider {
  @singleton
  Dio dio() {
    return Dio(
      BaseOptions(
        contentType: "application/json",
        followRedirects: false,
        receiveTimeout: const Duration(seconds: 20),
        sendTimeout: const Duration(seconds: 20),
      ),
    );
  }
}

/* @module là 1 annotation của injectable,
   => đánh dấu abstract class sau là một module, nơi đăng ký các dependencies */

@module
abstract class AppModule {
  @singleton
  Future<LocalDataManager> get localDataManager async =>
      LocalDataManager()..init();

  @singleton
  NavigationService get navigationService => NavigationService();
}
