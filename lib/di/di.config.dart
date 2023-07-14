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
    as _i14;
import '../data/data_source/remote/module_repositories/daily_weather_repository/weather_api_repository_impl.dart'
    as _i15;
import '../data/data_source/remote/module_repositories/hourly_temperature_repository/temperature_api_repository.dart'
    as _i5;
import '../data/data_source/remote/module_repositories/hourly_temperature_repository/temperature_api_repository_impl.dart'
    as _i6;
import '../data/data_source/remote/module_repositories/user_api_detail_repository.dart'
    as _i8;
import '../data/data_source/remote/module_repositories/user_api_detail_repository_impl.dart'
    as _i9;
import '../data/data_source/remote/module_repositories/user_api_repository.dart'
    as _i11;
import '../data/data_source/remote/module_repositories/user_api_repository_impl.dart'
    as _i12;
import '../domain/repositories/example/example_repository.dart' as _i16;
import '../domain/repositories/temperature_repo/temperature_repository.dart'
    as _i7;
import '../domain/repositories/user_detail_repository.dart' as _i21;
import '../domain/repositories/user_detail_repository.impl.dart' as _i22;
import '../domain/repositories/user_repository.dart' as _i23;
import '../domain/usecases/example_usecase/example_usecase.dart' as _i17;
import '../domain/usecases/temperature_usecase/temperature_usecase.dart'
    as _i20;
import '../domain/usecases/user_detail_usecase.dart' as _i10;
import '../domain/usecases/user_usecase.dart' as _i13;
import '../presentation/bloc/daily_weather_bloc/daily_weather_bloc.dart'
    as _i24;
import '../presentation/bloc/hourly_temperarute_bloc/hourly_temperature_bloc.dart'
    as _i25;
import '../presentation/bloc/login/login_bloc.dart' as _i4;
import '../presentation/bloc/userlist/get_user_bloc/get_user_bloc.dart' as _i18;
import '../presentation/bloc/userlist/get_user_detail_bloc%20copy/get_user_detail_bloc.dart'
    as _i19;
import 'di.dart' as _i26;

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
  gh.factory<_i5.TemperatureApiRepository>(
      () => _i6.TemperatureRepositoryImpl(dio: gh<_i3.Dio>()));
  gh.factory<_i7.TemperatureRepository>(
      () => _i7.TemperatureRepositoryImpl(gh<_i5.TemperatureApiRepository>()));
  gh.factory<_i8.UserDetailRepository>(
      () => _i9.UserDetailRepositoryImpl(dio: gh<_i3.Dio>()));
  gh.factory<_i10.UserDetailUsecase>(() => _i10.UserDetailUsecaseImpl(
        gh<_i8.UserDetailRepository>(),
        gh<_i8.UserDetailRepository>(),
        gh<_i8.UserDetailRepository>(),
      ));
  gh.factory<_i11.UserRepository>(
      () => _i12.UserRepositoryImpl(dio: gh<_i3.Dio>()));
  gh.factory<_i13.UserUsecase>(
      () => _i13.UserUsecaseImpl(gh<_i11.UserRepository>()));
  gh.factory<_i14.WeatherRepository>(
      () => _i15.WeatherRepositoryImpl(dio: gh<_i3.Dio>()));
  gh.factory<_i16.ExampleRepository>(
      () => _i16.ExampleRepositoryImpl(gh<_i14.WeatherRepository>()));
  gh.factory<_i17.ExampleUsecase>(
      () => _i17.ExampleUsecaseImpl(gh<_i14.WeatherRepository>()));
  gh.factory<_i18.GetUserBloc>(() => _i18.GetUserBloc(gh<_i13.UserUsecase>()));
  gh.factory<_i19.GetUserDetailBloc>(
      () => _i19.GetUserDetailBloc(gh<_i10.UserDetailUsecase>()));
  gh.factory<_i20.HourlyTemperatureUsecase>(() =>
      _i20.HourlyTemperatureUsecaseImpl(gh<_i5.TemperatureApiRepository>()));
  gh.factory<_i21.UserDetailModelRepository>(
      () => _i22.UserDetailRepositoryImpl(gh<_i8.UserDetailRepository>()));
  gh.factory<_i23.UserListRepository>(
      () => _i23.UserListRepositoryImpl(gh<_i11.UserRepository>()));
  gh.factory<_i24.DailyWeatherBloc>(
      () => _i24.DailyWeatherBloc(gh<_i17.ExampleUsecase>()));
  gh.factory<_i25.HourlyTemperatureBloc>(
      () => _i25.HourlyTemperatureBloc(gh<_i20.HourlyTemperatureUsecase>()));
  return getIt;
}

class _$DioProvider extends _i26.DioProvider {}
