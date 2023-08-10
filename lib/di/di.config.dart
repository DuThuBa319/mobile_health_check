// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i4;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../data/data_source/remote/module_repositories/blood_pressure_api_repository/blood_pressure_api_repository.dart'
    as _i17;
import '../data/data_source/remote/module_repositories/blood_pressure_api_repository/blood_pressure_api_repository.impl.dart'
    as _i18;
import '../data/data_source/remote/module_repositories/blood_sugar_api_repositoy/blood_sugar_api_repository.dart'
    as _i21;
import '../data/data_source/remote/module_repositories/blood_sugar_api_repositoy/blood_sugar_api_repository.impl.dart'
    as _i22;
import '../data/data_source/remote/module_repositories/temperature_api_repository/temperature_api_repository.dart'
    as _i7;
import '../data/data_source/remote/module_repositories/temperature_api_repository/temperature_api_repository.impl.dart'
    as _i8;
import '../data/data_source/remote/module_repositories/user_api_repository/user_api_detail_repository.dart'
    as _i11;
import '../data/data_source/remote/module_repositories/user_api_repository/user_api_detail_repository_impl.dart'
    as _i12;
import '../data/data_source/remote/module_repositories/user_api_repository/user_api_repository.dart'
    as _i14;
import '../data/data_source/remote/module_repositories/user_api_repository/user_api_repository_impl.dart'
    as _i15;
import '../domain/repositories/blood_pressure_repository/blood_pressure_repository.dart'
    as _i19;
import '../domain/repositories/blood_sugar_repository/blood_sugar_repository.dart'
    as _i23;
import '../domain/repositories/temperature_repository/temperature_repository.dart'
    as _i9;
import '../domain/repositories/user_repository/user_detail_repository.dart'
    as _i29;
import '../domain/repositories/user_repository/user_repository.dart' as _i30;
import '../domain/usecases/blood_pressure_usecase/blood_pressure_usecase.dart'
    as _i20;
import '../domain/usecases/blood_sugar_usecase/blood_sugar_usecase.dart'
    as _i24;
import '../domain/usecases/temperature_usecase/temperature_usecase.dart'
    as _i10;
import '../domain/usecases/user_usecase/user_detail_usecase.dart' as _i13;
import '../domain/usecases/user_usecase/user_usecase.dart' as _i16;
import '../presentation/bloc/login/login_bloc.dart' as _i6;
import '../presentation/bloc/userlist/get_user_bloc/get_user_bloc.dart' as _i25;
import '../presentation/bloc/userlist/get_user_detail_bloc/get_user_detail_bloc.dart'
    as _i26;
import '../presentation/common_widget/image_picker/image_picker_bloc/image_picker_bloc.dart'
    as _i5;
import '../presentation/modules/camera_demo/camera_bloc/camera_bloc.dart'
    as _i3;
import '../presentation/modules/history/bloc/history_bloc.dart' as _i27;
import '../presentation/modules/OCR_scanner/ocr_scanner_bloc/ocr_scanner_bloc.dart'
    as _i28;
import 'di.dart' as _i31;

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
  gh.factory<_i3.CameraBloc>(() => _i3.CameraBloc());
  gh.singleton<_i4.Dio>(dioProvider.dio());
  gh.factory<_i5.ImagePickerBloc>(() => _i5.ImagePickerBloc());
  gh.factory<_i6.LoginBloc>(() => _i6.LoginBloc());
  gh.factory<_i7.TemperatureApiRepository>(
      () => _i8.TemperatureApiRepositoryImpl(dio: gh<_i4.Dio>()));
  gh.factory<_i9.TemperatureRepository>(
      () => _i9.TemperatureRepositoryImpl(gh<_i7.TemperatureApiRepository>()));
  gh.factory<_i10.TemperatureUsecase>(
      () => _i10.TemperatureUsecaseImpl(gh<_i9.TemperatureRepository>()));
  gh.factory<_i11.UserDetailRepository>(
      () => _i12.UserDetailRepositoryImpl(dio: gh<_i4.Dio>()));
  gh.factory<_i13.UserDetailUsecase>(() => _i13.UserDetailUsecaseImpl(
        gh<_i11.UserDetailRepository>(),
        gh<_i11.UserDetailRepository>(),
      ));
  gh.factory<_i14.UserRepository>(
      () => _i15.UserRepositoryImpl(dio: gh<_i4.Dio>()));
  gh.factory<_i16.UserUsecase>(
      () => _i16.UserUsecaseImpl(gh<_i14.UserRepository>()));
  gh.factory<_i17.BloodPressureApiRepository>(
      () => _i18.BloodPressureApiRepositoryImpl(dio: gh<_i4.Dio>()));
  gh.factory<_i19.BloodPressureRepository>(() =>
      _i19.BloodPressureRepositoryImpl(gh<_i17.BloodPressureApiRepository>()));
  gh.factory<_i20.BloodPressureUsecase>(
      () => _i20.BloodPressureUsecaseImpl(gh<_i19.BloodPressureRepository>()));
  gh.factory<_i21.BloodSugarApiRepository>(
      () => _i22.BloodSugarApiRepositoryImpl(dio: gh<_i4.Dio>()));
  gh.factory<_i23.BloodSugarRepository>(
      () => _i23.BloodSugarRepositoryImpl(gh<_i21.BloodSugarApiRepository>()));
  gh.factory<_i24.BloodSugarUsecase>(
      () => _i24.BloodSugarUsecaseImpl(gh<_i23.BloodSugarRepository>()));
  gh.factory<_i25.GetUserBloc>(() => _i25.GetUserBloc(gh<_i16.UserUsecase>()));
  gh.factory<_i26.GetUserDetailBloc>(
      () => _i26.GetUserDetailBloc(gh<_i13.UserDetailUsecase>()));
  gh.factory<_i27.HistoryBloc>(() => _i27.HistoryBloc(
        gh<_i20.BloodPressureUsecase>(),
        gh<_i24.BloodSugarUsecase>(),
        gh<_i10.TemperatureUsecase>(),
      ));
  gh.factory<_i28.OCRScannerBloc>(
      () => _i28.OCRScannerBloc(gh<_i20.BloodPressureUsecase>()));
  gh.factory<_i29.UserDetailModelRepository>(
      () => _i29.UserDetailRepositoryImpl(gh<_i11.UserDetailRepository>()));
  gh.factory<_i30.UserListRepository>(
      () => _i30.UserListRepositoryImpl(gh<_i14.UserRepository>()));
  return getIt;
}

class _$DioProvider extends _i31.DioProvider {}
