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

import '../data/data_source/remote/module_repositories/user_api_repository.dart'
    as _i4;
import '../data/data_source/remote/module_repositories/user_api_repository_impl.dart'
    as _i5;
import '../domain/repositories/user_repository.dart' as _i8;
import '../domain/usecases/user_usecase.dart' as _i6;
import '../presentation/bloc/login/login_bloc.dart' as _i7;
import 'di.dart' as _i9;

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
  gh.factory<_i4.UserRepository>(
      () => _i5.UserRepositoryImpl(dio: gh<_i3.Dio>()));
  gh.factory<_i6.UserUsecase>(
      () => _i6.UserUsecaseImpl(gh<_i4.UserRepository>()));
  gh.factory<_i7.LoginBloc>(() => _i7.LoginBloc(gh<_i6.UserUsecase>()));
  gh.factory<_i8.LoginRepository>(
      () => _i8.LoginRepositoryImpl(gh<_i4.UserRepository>()));
  return getIt;
}

class _$DioProvider extends _i9.DioProvider {}
