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
    as _i15;
import '../data/data_source/remote/module_repositories/blood_pressure_api_repository/blood_pressure_api_repository.impl.dart'
    as _i16;
import '../data/data_source/remote/module_repositories/blood_sugar_api_repositoy/blood_sugar_api_repository.dart'
    as _i19;
import '../data/data_source/remote/module_repositories/blood_sugar_api_repositoy/blood_sugar_api_repository.impl.dart'
    as _i20;
import '../data/data_source/remote/module_repositories/temperature_api_repository/temperature_api_repository.dart'
    as _i6;
import '../data/data_source/remote/module_repositories/temperature_api_repository/temperature_api_repository.impl.dart'
    as _i7;
import '../data/data_source/remote/module_repositories/user_api_repository/user_api_detail_repository.dart'
    as _i10;
import '../data/data_source/remote/module_repositories/user_api_repository/user_api_detail_repository_impl.dart'
    as _i11;
import '../data/data_source/remote/module_repositories/user_api_repository/user_api_repository.dart'
    as _i12;
import '../data/data_source/remote/module_repositories/user_api_repository/user_api_repository_impl.dart'
    as _i13;
import '../domain/repositories/blood_pressure_repository/blood_pressure_repository.dart'
    as _i17;
import '../domain/repositories/blood_sugar_repository/blood_sugar_repository.dart'
    as _i21;
import '../domain/repositories/temperature_repository/temperature_repository.dart'
    as _i8;
import '../domain/repositories/user_repository/user_detail_repository.dart'
    as _i26;
import '../domain/repositories/user_repository/user_repository.dart' as _i27;
import '../domain/usecases/blood_pressure_usecase/blood_pressure_usecase.dart'
    as _i18;
import '../domain/usecases/blood_sugar_usecase/blood_sugar_usecase.dart'
    as _i22;
import '../domain/usecases/temperature_usecase/temperature_usecase.dart' as _i9;
import '../domain/usecases/user_usecase/user_usecase.dart' as _i14;
import '../presentation/bloc/userlist/get_user_bloc/get_user_bloc.dart' as _i23;
import '../presentation/common_widget/image_picker/image_picker_bloc/image_picker_bloc.dart'
    as _i5;
import '../presentation/modules/camera_demo/camera_bloc/camera_bloc.dart'
    as _i3;
import '../presentation/modules/history/bloc/history_bloc.dart' as _i24;
import '../presentation/modules/OCR_scanner/ocr_scanner_bloc/ocr_scanner_bloc.dart'
    as _i25;
import 'di.dart' as _i28;

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
  gh.factory<_i6.TemperatureApiRepository>(
      () => _i7.TemperatureApiRepositoryImpl(dio: gh<_i4.Dio>()));
  gh.factory<_i8.TemperatureRepository>(
      () => _i8.TemperatureRepositoryImpl(gh<_i6.TemperatureApiRepository>()));
  gh.factory<_i9.TemperatureUsecase>(
      () => _i9.TemperatureUsecaseImpl(gh<_i8.TemperatureRepository>()));
  gh.factory<_i10.UserDetailRepository>(
      () => _i11.UserDetailRepositoryImpl(dio: gh<_i4.Dio>()));
  gh.factory<_i12.UserRepository>(
      () => _i13.UserRepositoryImpl(dio: gh<_i4.Dio>()));
  gh.factory<_i14.UserUsecase>(
      () => _i14.UserUsecaseImpl(gh<_i12.UserRepository>()));
  gh.factory<_i15.BloodPressureApiRepository>(
      () => _i16.BloodPressureApiRepositoryImpl(dio: gh<_i4.Dio>()));
  gh.factory<_i17.BloodPressureRepository>(() =>
      _i17.BloodPressureRepositoryImpl(gh<_i15.BloodPressureApiRepository>()));
  gh.factory<_i18.BloodPressureUsecase>(
      () => _i18.BloodPressureUsecaseImpl(gh<_i17.BloodPressureRepository>()));
  gh.factory<_i19.BloodSugarApiRepository>(
      () => _i20.BloodSugarApiRepositoryImpl(dio: gh<_i4.Dio>()));
  gh.factory<_i21.BloodSugarRepository>(
      () => _i21.BloodSugarRepositoryImpl(gh<_i19.BloodSugarApiRepository>()));
  gh.factory<_i22.BloodSugarUsecase>(
      () => _i22.BloodSugarUsecaseImpl(gh<_i21.BloodSugarRepository>()));
  gh.factory<_i23.GetUserBloc>(() => _i23.GetUserBloc(gh<_i14.UserUsecase>()));
  gh.factory<_i24.HistoryBloc>(() => _i24.HistoryBloc(
        gh<_i18.BloodPressureUsecase>(),
        gh<_i22.BloodSugarUsecase>(),
        gh<_i9.TemperatureUsecase>(),
      ));
  gh.factory<_i25.OCRScannerBloc>(
      () => _i25.OCRScannerBloc(gh<_i18.BloodPressureUsecase>()));
  gh.factory<_i26.UserDetailModelRepository>(
      () => _i26.UserDetailRepositoryImpl(gh<_i10.UserDetailRepository>()));
  gh.factory<_i27.UserListRepository>(
      () => _i27.UserListRepositoryImpl(gh<_i12.UserRepository>()));
  return getIt;
}

class _$DioProvider extends _i28.DioProvider {}
