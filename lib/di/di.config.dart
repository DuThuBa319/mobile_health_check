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
    as _i11;
import '../data/data_source/remote/module_repositories/daily_weather_repository/weather_api_repository_impl.dart'
    as _i12;
import '../data/data_source/remote/module_repositories/user_api_detail_repository.dart'
    as _i5;
import '../data/data_source/remote/module_repositories/user_api_detail_repository_impl.dart'
    as _i6;
import '../data/data_source/remote/module_repositories/user_api_repository.dart'
    as _i8;
import '../data/data_source/remote/module_repositories/user_api_repository_impl.dart'
    as _i9;
import '../domain/repositories/example/example_repository.dart' as _i13;
import '../domain/repositories/user_detail_repository.dart' as _i17;
import '../domain/repositories/user_detail_repository.impl.dart' as _i18;
import '../domain/repositories/user_repository.dart' as _i19;
import '../domain/usecases/example_usecase/example_usecase.dart' as _i14;
import '../domain/usecases/user_detail_usecase.dart' as _i7;
import '../domain/usecases/user_usecase.dart' as _i10;
import '../presentation/bloc/daily_weather_bloc/daily_weather_bloc.dart'
    as _i20;
import '../presentation/bloc/login/login_bloc.dart' as _i4;
import '../presentation/bloc/userlist/get_user_bloc/get_user_bloc.dart' as _i15;
import '../presentation/bloc/userlist/get_user_detail_bloc%20copy/get_user_detail_bloc.dart'
    as _i16;
import 'di.dart' as _i21;

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
  gh.factory<_i5.UserDetailRepository>(
      () => _i6.UserDetailRepositoryImpl(dio: gh<_i3.Dio>()));
  gh.factory<_i7.UserDetailUsecase>(() => _i7.UserDetailUsecaseImpl(
        gh<_i5.UserDetailRepository>(),
        gh<_i5.UserDetailRepository>(),
        gh<_i5.UserDetailRepository>(),
      ));
  gh.factory<_i8.UserRepository>(
      () => _i9.UserRepositoryImpl(dio: gh<_i3.Dio>()));
  gh.factory<_i10.UserUsecase>(
      () => _i10.UserUsecaseImpl(gh<_i8.UserRepository>()));
  gh.factory<_i11.WeatherRepository>(
      () => _i12.WeatherRepositoryImpl(dio: gh<_i3.Dio>()));
  gh.factory<_i13.ExampleRepository>(
      () => _i13.ExampleRepositoryImpl(gh<_i11.WeatherRepository>()));
  gh.factory<_i14.ExampleUsecase>(
      () => _i14.ExampleUsecaseImpl(gh<_i11.WeatherRepository>()));
  gh.factory<_i15.GetUserBloc>(() => _i15.GetUserBloc(gh<_i10.UserUsecase>()));
  gh.factory<_i16.GetUserDetailBloc>(
      () => _i16.GetUserDetailBloc(gh<_i7.UserDetailUsecase>()));
  gh.factory<_i17.UserDetailModelRepository>(
      () => _i18.UserDetailRepositoryImpl(gh<_i5.UserDetailRepository>()));
  gh.factory<_i19.UserListRepository>(
      () => _i19.UserListRepositoryImpl(gh<_i8.UserRepository>()));
  gh.factory<_i20.DailyWeatherBloc>(
      () => _i20.DailyWeatherBloc(gh<_i14.ExampleUsecase>()));
  return getIt;
}

class _$DioProvider extends _i21.DioProvider {}
