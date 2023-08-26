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

import '../common/service/onesginal/onesignal_service.dart' as _i6;
import '../data/data_source/remote/module_repositories/blood_pressure_api_repository/blood_pressure_api_repository.dart'
    as _i15;
import '../data/data_source/remote/module_repositories/blood_pressure_api_repository/blood_pressure_api_repository_impl.dart'
    as _i16;
import '../data/data_source/remote/module_repositories/blood_sugar_api_repositoy/blood_sugar_api_repository.dart'
    as _i19;
import '../data/data_source/remote/module_repositories/blood_sugar_api_repositoy/blood_sugar_api_repository_impl.dart'
    as _i20;
import '../data/data_source/remote/module_repositories/patient_api_repository/patient_api_repository.dart'
    as _i7;
import '../data/data_source/remote/module_repositories/patient_api_repository/patient_api_repository_impl.dart'
    as _i8;
import '../data/data_source/remote/module_repositories/temperature_api_repository/temperature_api_repository.dart'
    as _i11;
import '../data/data_source/remote/module_repositories/temperature_api_repository/temperature_api_repository_impl.dart'
    as _i12;
import '../domain/repositories/blood_pressure_repository/blood_pressure_repository.dart'
    as _i17;
import '../domain/repositories/blood_sugar_repository/blood_sugar_repository.dart'
    as _i21;
import '../domain/repositories/patient_repository/patient_repository.dart'
    as _i9;
import '../domain/repositories/temperature_repository/temperature_repository.dart'
    as _i13;
import '../domain/usecases/blood_pressure_usecase/blood_pressure_usecase.dart'
    as _i18;
import '../domain/usecases/blood_sugar_usecase/blood_sugar_usecase.dart'
    as _i22;
import '../domain/usecases/patient_usecase/patient_usecase.dart' as _i10;
import '../domain/usecases/temperature_usecase/temperature_usecase.dart'
    as _i14;
import '../presentation/common_widget/image_picker/image_picker_bloc/image_picker_bloc.dart'
    as _i5;
import '../presentation/modules/camera_demo/camera_bloc/camera_bloc.dart'
    as _i3;
import '../presentation/modules/history/history_bloc/history_bloc.dart' as _i24;
import '../presentation/modules/OCR_scanner/ocr_scanner_bloc/ocr_scanner_bloc.dart'
    as _i25;
import '../presentation/modules/patient/bloc/get_patient_bloc.dart' as _i23;
import 'di.dart' as _i26;

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
  gh.singletonAsync<_i6.OneSignalNotificationService>(
      () => _i6.OneSignalNotificationService.create());
  gh.factory<_i7.PatientApiRepository>(
      () => _i8.PatientApiRepositoryImpl(dio: gh<_i4.Dio>()));
  gh.factory<_i9.PatientListRepository>(
      () => _i9.PatientListRepositoryImpl(gh<_i7.PatientApiRepository>()));
  gh.factory<_i10.PatientUsecase>(
      () => _i10.PatientUsecaseImpl(gh<_i9.PatientListRepository>()));
  gh.factory<_i11.TemperatureApiRepository>(
      () => _i12.TemperatureApiRepositoryImpl(dio: gh<_i4.Dio>()));
  gh.factory<_i13.TemperatureRepository>(() =>
      _i13.TemperatureRepositoryImpl(gh<_i11.TemperatureApiRepository>()));
  gh.factory<_i14.TemperatureUsecase>(
      () => _i14.TemperatureUsecaseImpl(gh<_i13.TemperatureRepository>()));
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
  gh.factory<_i23.GetPatientBloc>(
      () => _i23.GetPatientBloc(gh<_i10.PatientUsecase>()));
  gh.factory<_i24.HistoryBloc>(() => _i24.HistoryBloc(
        gh<_i18.BloodPressureUsecase>(),
        gh<_i22.BloodSugarUsecase>(),
        gh<_i14.TemperatureUsecase>(),
      ));
  gh.factory<_i25.OCRScannerBloc>(
      () => _i25.OCRScannerBloc(gh<_i18.BloodPressureUsecase>()));
  return getIt;
}

class _$DioProvider extends _i26.DioProvider {}
