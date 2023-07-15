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
    as _i12;
import '../data/data_source/remote/module_repositories/daily_weather_repository/weather_api_repository_impl.dart'
    as _i13;
import '../data/data_source/remote/module_repositories/user_api_detail_repository.dart'
    as _i6;
import '../data/data_source/remote/module_repositories/user_api_detail_repository_impl.dart'
    as _i7;
import '../data/data_source/remote/module_repositories/user_api_repository.dart'
    as _i9;
import '../data/data_source/remote/module_repositories/user_api_repository_impl.dart'
    as _i10;
import '../domain/repositories/example/example_repository.dart' as _i14;
import '../domain/repositories/user_detail_repository.dart' as _i18;
import '../domain/repositories/user_detail_repository.impl.dart' as _i19;
import '../domain/repositories/user_repository.dart' as _i20;
import '../domain/usecases/example_usecase/example_usecase.dart' as _i15;
import '../domain/usecases/user_detail_usecase.dart' as _i8;
import '../domain/usecases/user_usecase.dart' as _i11;
import '../presentation/bloc/daily_weather_bloc/daily_weather_bloc.dart'
    as _i21;
import '../presentation/bloc/login/login_bloc.dart' as _i5;
import '../presentation/bloc/userlist/get_user_bloc/get_user_bloc.dart' as _i16;
import '../presentation/bloc/userlist/get_user_detail_bloc/get_user_detail_bloc.dart'
    as _i17;
import '../presentation/common_widget/image_picker/image_picker_bloc/image_picker_bloc.dart'
    as _i4;
import 'di.dart' as _i22;

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
  gh.factory<_i6.UserDetailRepository>(
      () => _i7.UserDetailRepositoryImpl(dio: gh<_i3.Dio>()));
  gh.factory<_i8.UserDetailUsecase>(() => _i8.UserDetailUsecaseImpl(
        gh<_i6.UserDetailRepository>(),
        gh<_i6.UserDetailRepository>(),
        gh<_i6.UserDetailRepository>(),
      ));
  gh.factory<_i9.UserRepository>(
      () => _i10.UserRepositoryImpl(dio: gh<_i3.Dio>()));
  gh.factory<_i11.UserUsecase>(
      () => _i11.UserUsecaseImpl(gh<_i9.UserRepository>()));
  gh.factory<_i12.WeatherRepository>(
      () => _i13.WeatherRepositoryImpl(dio: gh<_i3.Dio>()));
  gh.factory<_i14.ExampleRepository>(
      () => _i14.ExampleRepositoryImpl(gh<_i12.WeatherRepository>()));
  gh.factory<_i15.ExampleUsecase>(
      () => _i15.ExampleUsecaseImpl(gh<_i12.WeatherRepository>()));
  gh.factory<_i16.GetUserBloc>(() => _i16.GetUserBloc(gh<_i11.UserUsecase>()));
  gh.factory<_i17.GetUserDetailBloc>(
      () => _i17.GetUserDetailBloc(gh<_i8.UserDetailUsecase>()));
  gh.factory<_i18.UserDetailModelRepository>(
      () => _i19.UserDetailRepositoryImpl(gh<_i6.UserDetailRepository>()));
  gh.factory<_i20.UserListRepository>(
      () => _i20.UserListRepositoryImpl(gh<_i9.UserRepository>()));
  gh.factory<_i21.DailyWeatherBloc>(
      () => _i21.DailyWeatherBloc(gh<_i15.ExampleUsecase>()));
  return getIt;
}

class _$DioProvider extends _i22.DioProvider {}
