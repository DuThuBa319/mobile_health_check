import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'di.config.dart';

GetIt injector = GetIt.instance;
final getIt = GetIt.instance;
@InjectableInit(
  initializerName: r'$initGetIt',
  preferRelativeImports: true,
  asExtension: false,
)
void configureDependencies() => $initGetIt(injector);

@module
abstract class DioProvider {
  @singleton
  Dio dio() {
    return Dio(
      BaseOptions(
        contentType: "application/json",
        followRedirects: false,
        receiveTimeout: 30000, // 30s
        sendTimeout: 30000,
      ),
    );
  }
}
