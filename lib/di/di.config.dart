// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i3;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../data/data_source/remote/module_repositories/daily_weather_repository/weather_api_repository.dart'
    as _i8;
import '../data/data_source/remote/module_repositories/daily_weather_repository/weather_api_repository_impl.dart'
    as _i9;
import '../data/data_source/remote/module_repositories/user_api_repository.dart'
    as _i5;
import '../data/data_source/remote/module_repositories/user_api_repository_impl.dart'
    as _i6;
import '../domain/repositories/example/example_repository.dart' as _i10;
import '../domain/repositories/user_repository.dart' as _i12;
import '../domain/usecases/example_usecase/example_usecase.dart' as _i11;
import '../domain/usecases/user_usecase.dart' as _i7;
import '../presentation/bloc/daily_weather_bloc/daily_weather_bloc.dart'
    as _i13;
import '../presentation/bloc/login/login_bloc.dart' as _i4;
import 'di.dart' as _i14;

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// initializes the registration of main-scope dependencies inside of GetIt
_i1.GetIt $initGetIt(
  _i1.GetIt getIt, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i2.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  final dioProvider = _$DioProvider();
  gh.singleton<_i3.Dio>(dioProvider.dio());
  gh.factory<_i4.LoginBloc>(() => _i4.LoginBloc());
  gh.factory<_i5.UserRepository>(
      () => _i6.UserRepositoryImpl(dio: gh<_i3.Dio>()));
  gh.factory<_i7.UserUsecase>(
      () => _i7.UserUsecaseImpl(gh<_i5.UserRepository>()));
  gh.factory<_i8.WeatherRepository>(
      () => _i9.WeatherRepositoryImpl(dio: gh<_i3.Dio>()));
  gh.factory<_i10.ExampleRepository>(
      () => _i10.ExampleRepositoryImpl(gh<_i8.WeatherRepository>()));
  gh.factory<_i11.ExampleUsecase>(
      () => _i11.ExampleUsecaseImpl(gh<_i8.WeatherRepository>()));
  gh.factory<_i12.LoginRepository>(
      () => _i12.LoginRepositoryImpl(gh<_i5.UserRepository>()));
  gh.factory<_i13.DailyWeatherBloc>(
      () => _i13.DailyWeatherBloc(gh<_i11.ExampleUsecase>()));
  return getIt;
}

class _$DioProvider extends _i14.DioProvider {}
