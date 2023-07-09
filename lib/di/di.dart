import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

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
}

@module
abstract class DioProvider {
  @singleton
  Dio dio() {
    return Dio(
      BaseOptions(
        contentType: "application/json",
        followRedirects: false,
        receiveTimeout: const Duration(milliseconds: 60000), // 30s
        sendTimeout: const Duration(milliseconds: 60000),
      ),
    );
  }
}
