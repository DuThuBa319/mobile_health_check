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
    as _i15;
import '../data/data_source/remote/module_repositories/daily_weather_repository/weather_api_repository_impl.dart'
    as _i16;
import '../data/data_source/remote/module_repositories/hourly_temperature_repository/temperature_api_repository.dart'
    as _i6;
import '../data/data_source/remote/module_repositories/hourly_temperature_repository/temperature_api_repository_impl.dart'
    as _i7;
import '../data/data_source/remote/module_repositories/user_api_detail_repository.dart'
    as _i9;
import '../data/data_source/remote/module_repositories/user_api_detail_repository_impl.dart'
    as _i10;
import '../data/data_source/remote/module_repositories/user_api_repository.dart'
    as _i12;
import '../data/data_source/remote/module_repositories/user_api_repository_impl.dart'
    as _i13;
import '../domain/repositories/example/example_repository.dart' as _i17;
import '../domain/repositories/temperature_repo/temperature_repository.dart'
    as _i8;
import '../domain/repositories/user_detail_repository.dart' as _i22;
import '../domain/repositories/user_detail_repository.impl.dart' as _i23;
import '../domain/repositories/user_repository.dart' as _i24;
import '../domain/usecases/example_usecase/example_usecase.dart' as _i18;
import '../domain/usecases/temperature_usecase/temperature_usecase.dart'
    as _i21;
import '../domain/usecases/user_detail_usecase.dart' as _i11;
import '../domain/usecases/user_usecase.dart' as _i14;
import '../presentation/bloc/daily_weather_bloc/daily_weather_bloc.dart'
    as _i25;
import '../presentation/bloc/hourly_temperarute_bloc/hourly_temperature_bloc.dart'
    as _i26;
import '../presentation/bloc/login/login_bloc.dart' as _i5;
import '../presentation/bloc/userlist/get_user_bloc/get_user_bloc.dart' as _i19;
import '../presentation/bloc/userlist/get_user_detail_bloc/get_user_detail_bloc.dart'
    as _i20;
import '../presentation/common_widget/image_picker/image_picker_bloc/image_picker_bloc.dart'
    as _i4;
import 'di.dart' as _i27;

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
  gh.factory<_i4.ImagePickerBloc>(() => _i4.ImagePickerBloc());
  gh.factory<_i5.LoginBloc>(() => _i5.LoginBloc());
  gh.factory<_i6.TemperatureApiRepository>(
      () => _i7.TemperatureRepositoryImpl(dio: gh<_i3.Dio>()));
  gh.factory<_i8.TemperatureRepository>(
      () => _i8.TemperatureRepositoryImpl(gh<_i6.TemperatureApiRepository>()));
  gh.factory<_i9.UserDetailRepository>(
      () => _i10.UserDetailRepositoryImpl(dio: gh<_i3.Dio>()));
  gh.factory<_i11.UserDetailUsecase>(() => _i11.UserDetailUsecaseImpl(
        gh<_i9.UserDetailRepository>(),
        gh<_i9.UserDetailRepository>(),
        gh<_i9.UserDetailRepository>(),
      ));
  gh.factory<_i12.UserRepository>(
      () => _i13.UserRepositoryImpl(dio: gh<_i3.Dio>()));
  gh.factory<_i14.UserUsecase>(
      () => _i14.UserUsecaseImpl(gh<_i12.UserRepository>()));
  gh.factory<_i15.WeatherRepository>(
      () => _i16.WeatherRepositoryImpl(dio: gh<_i3.Dio>()));
  gh.factory<_i17.ExampleRepository>(
      () => _i17.ExampleRepositoryImpl(gh<_i15.WeatherRepository>()));
  gh.factory<_i18.ExampleUsecase>(
      () => _i18.ExampleUsecaseImpl(gh<_i15.WeatherRepository>()));
  gh.factory<_i19.GetUserBloc>(() => _i19.GetUserBloc(gh<_i14.UserUsecase>()));
  gh.factory<_i20.GetUserDetailBloc>(
      () => _i20.GetUserDetailBloc(gh<_i11.UserDetailUsecase>()));
  gh.factory<_i21.HourlyTemperatureUsecase>(() =>
      _i21.HourlyTemperatureUsecaseImpl(gh<_i6.TemperatureApiRepository>()));
  gh.factory<_i22.UserDetailModelRepository>(
      () => _i23.UserDetailRepositoryImpl(gh<_i9.UserDetailRepository>()));
  gh.factory<_i24.UserListRepository>(
      () => _i24.UserListRepositoryImpl(gh<_i12.UserRepository>()));
  gh.factory<_i25.DailyWeatherBloc>(
      () => _i25.DailyWeatherBloc(gh<_i18.ExampleUsecase>()));
  gh.factory<_i26.HourlyTemperatureBloc>(
      () => _i26.HourlyTemperatureBloc(gh<_i21.HourlyTemperatureUsecase>()));
  return getIt;
}

class _$DioProvider extends _i27.DioProvider {}
