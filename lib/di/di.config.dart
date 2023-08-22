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
    as _i14;
import '../data/data_source/remote/module_repositories/blood_pressure_api_repository/blood_pressure_api_repository.impl.dart'
    as _i15;
import '../data/data_source/remote/module_repositories/blood_sugar_api_repositoy/blood_sugar_api_repository.dart'
    as _i18;
import '../data/data_source/remote/module_repositories/blood_sugar_api_repositoy/blood_sugar_api_repository.impl.dart'
    as _i19;
import '../data/data_source/remote/module_repositories/patient_api_repository/patient_api_repository_impl.dart'
    as _i11;
import '../data/data_source/remote/module_repositories/patient_api_repository/user_api_repository.dart'
    as _i10;
import '../data/data_source/remote/module_repositories/temperature_api_repository/temperature_api_repository.dart'
    as _i6;
import '../data/data_source/remote/module_repositories/temperature_api_repository/temperature_api_repository.impl.dart'
    as _i7;
import '../domain/repositories/blood_pressure_repository/blood_pressure_repository.dart'
    as _i16;
import '../domain/repositories/blood_sugar_repository/blood_sugar_repository.dart'
    as _i20;
import '../domain/repositories/patient_repository/patient_repository.dart'
    as _i12;
import '../domain/repositories/temperature_repository/temperature_repository.dart'
    as _i8;
import '../domain/usecases/blood_pressure_usecase/blood_pressure_usecase.dart'
    as _i17;
import '../domain/usecases/blood_sugar_usecase/blood_sugar_usecase.dart'
    as _i21;
import '../domain/usecases/patient_usecase/patient_usecase.dart' as _i13;
import '../domain/usecases/temperature_usecase/temperature_usecase.dart' as _i9;
import '../presentation/common_widget/image_picker/image_picker_bloc/image_picker_bloc.dart'
    as _i5;
import '../presentation/modules/camera_demo/camera_bloc/camera_bloc.dart'
    as _i3;
import '../presentation/modules/history/history_bloc/history_bloc.dart' as _i23;
import '../presentation/modules/patient/patient_list_&_infor_bloc/get_patient_bloc.dart'
    as _i22;
import 'di.dart' as _i24;

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
  gh.factory<_i10.UserApiRepository>(
      () => _i11.UserApiRepositoryImpl(dio: gh<_i4.Dio>()));
  gh.factory<_i12.UserListRepository>(
      () => _i12.UserListRepositoryImpl(gh<_i10.UserApiRepository>()));
  gh.factory<_i13.UserUsecase>(
      () => _i13.UserUsecaseImpl(gh<_i12.UserListRepository>()));
  gh.factory<_i14.BloodPressureApiRepository>(
      () => _i15.BloodPressureApiRepositoryImpl(dio: gh<_i4.Dio>()));
  gh.factory<_i16.BloodPressureRepository>(() =>
      _i16.BloodPressureRepositoryImpl(gh<_i14.BloodPressureApiRepository>()));
  gh.factory<_i17.BloodPressureUsecase>(
      () => _i17.BloodPressureUsecaseImpl(gh<_i16.BloodPressureRepository>()));
  gh.factory<_i18.BloodSugarApiRepository>(
      () => _i19.BloodSugarApiRepositoryImpl(dio: gh<_i4.Dio>()));
  gh.factory<_i20.BloodSugarRepository>(
      () => _i20.BloodSugarRepositoryImpl(gh<_i18.BloodSugarApiRepository>()));
  gh.factory<_i21.BloodSugarUsecase>(
      () => _i21.BloodSugarUsecaseImpl(gh<_i20.BloodSugarRepository>()));
  gh.factory<_i22.GetUserBloc>(() => _i22.GetUserBloc(gh<_i13.UserUsecase>()));
  gh.factory<_i23.HistoryBloc>(() => _i23.HistoryBloc(
        gh<_i17.BloodPressureUsecase>(),
        gh<_i21.BloodSugarUsecase>(),
        gh<_i9.TemperatureUsecase>(),
      ));
  return getIt;
}

class _$DioProvider extends _i24.DioProvider {}