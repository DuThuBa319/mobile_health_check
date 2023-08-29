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

import '../common/service/firebase/firebase_auth_service.dart' as _i5;
import '../common/service/local_manager/local_data_manager.dart' as _i7;
import '../common/service/local_manager/notification_datasource/notification_datasource.dart'
    as _i9;
import '../common/service/local_manager/notification_datasource/notification_datasource.impl.dart'
    as _i10;
import '../common/service/local_manager/user_data_datasource/user_data_datasource.dart'
    as _i20;
import '../common/service/local_manager/user_data_datasource/user_data_datasource.impl.dart'
    as _i21;
import '../common/service/onesginal/bloc/notification_bloc.dart' as _i8;
import '../common/service/onesginal/onesignal_service.dart' as _i11;
import '../data/data_source/remote/module_repositories/blood_pressure_api_repository/blood_pressure_api_repository.dart'
    as _i22;
import '../data/data_source/remote/module_repositories/blood_pressure_api_repository/blood_pressure_api_repository_impl.dart'
    as _i23;
import '../data/data_source/remote/module_repositories/blood_sugar_api_repositoy/blood_sugar_api_repository.dart'
    as _i26;
import '../data/data_source/remote/module_repositories/blood_sugar_api_repositoy/blood_sugar_api_repository_impl.dart'
    as _i27;
import '../data/data_source/remote/module_repositories/patient_api_repository/patient_api_repository.dart'
    as _i12;
import '../data/data_source/remote/module_repositories/patient_api_repository/patient_api_repository_impl.dart'
    as _i13;
import '../data/data_source/remote/module_repositories/temperature_api_repository/temperature_api_repository.dart'
    as _i16;
import '../data/data_source/remote/module_repositories/temperature_api_repository/temperature_api_repository_impl.dart'
    as _i17;
import '../domain/repositories/blood_pressure_repository/blood_pressure_repository.dart'
    as _i24;
import '../domain/repositories/blood_sugar_repository/blood_sugar_repository.dart'
    as _i28;
import '../domain/repositories/patient_repository/patient_repository.dart'
    as _i14;
import '../domain/repositories/temperature_repository/temperature_repository.dart'
    as _i18;
import '../domain/usecases/blood_pressure_usecase/blood_pressure_usecase.dart'
    as _i25;
import '../domain/usecases/blood_sugar_usecase/blood_sugar_usecase.dart'
    as _i29;
import '../domain/usecases/patient_usecase/patient_usecase.dart' as _i15;
import '../domain/usecases/temperature_usecase/temperature_usecase.dart'
    as _i19;
import '../presentation/common_widget/image_picker/image_picker_bloc/image_picker_bloc.dart'
    as _i6;
import '../presentation/modules/camera_demo/camera_bloc/camera_bloc.dart'
    as _i3;
import '../presentation/modules/history/history_bloc/history_bloc.dart' as _i31;
import '../presentation/modules/OCR_scanner/ocr_scanner_bloc/ocr_scanner_bloc.dart'
    as _i32;
import '../presentation/modules/patient/bloc/get_patient_bloc.dart' as _i30;
import 'di.dart' as _i33;

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
  final appModule = _$AppModule();
  gh.factory<_i3.CameraBloc>(() => _i3.CameraBloc());
  gh.singleton<_i4.Dio>(dioProvider.dio());
  gh.singleton<_i5.FirebaseAuthService>(_i5.FirebaseAuthService());
  gh.factory<_i6.ImagePickerBloc>(() => _i6.ImagePickerBloc());
  gh.singletonAsync<_i7.LocalDataManager>(() => appModule.localDataManager);
  gh.factory<_i8.NotificationBloc>(() => _i8.NotificationBloc());
  gh.factory<_i9.NotificationDataSource>(
      () => _i10.NotificationDataSourceImpl());
  gh.singletonAsync<_i11.OneSignalNotificationService>(
      () => _i11.OneSignalNotificationService.create());
  gh.factory<_i12.PatientApiRepository>(
      () => _i13.PatientApiRepositoryImpl(dio: gh<_i4.Dio>()));
  gh.factory<_i14.PatientListRepository>(
      () => _i14.PatientListRepositoryImpl(gh<_i12.PatientApiRepository>()));
  gh.factory<_i15.PatientUsecase>(
      () => _i15.PatientUsecaseImpl(gh<_i14.PatientListRepository>()));
  gh.factory<_i16.TemperatureApiRepository>(
      () => _i17.TemperatureApiRepositoryImpl(dio: gh<_i4.Dio>()));
  gh.factory<_i18.TemperatureRepository>(() =>
      _i18.TemperatureRepositoryImpl(gh<_i16.TemperatureApiRepository>()));
  gh.factory<_i19.TemperatureUsecase>(
      () => _i19.TemperatureUsecaseImpl(gh<_i18.TemperatureRepository>()));
  gh.factory<_i20.UserDataDataSource>(() => _i21.UserDataDataSourceImpl());
  gh.factory<_i22.BloodPressureApiRepository>(
      () => _i23.BloodPressureApiRepositoryImpl(dio: gh<_i4.Dio>()));
  gh.factory<_i24.BloodPressureRepository>(() =>
      _i24.BloodPressureRepositoryImpl(gh<_i22.BloodPressureApiRepository>()));
  gh.factory<_i25.BloodPressureUsecase>(
      () => _i25.BloodPressureUsecaseImpl(gh<_i24.BloodPressureRepository>()));
  gh.factory<_i26.BloodSugarApiRepository>(
      () => _i27.BloodSugarApiRepositoryImpl(dio: gh<_i4.Dio>()));
  gh.factory<_i28.BloodSugarRepository>(
      () => _i28.BloodSugarRepositoryImpl(gh<_i26.BloodSugarApiRepository>()));
  gh.factory<_i29.BloodSugarUsecase>(
      () => _i29.BloodSugarUsecaseImpl(gh<_i28.BloodSugarRepository>()));
  gh.factory<_i30.GetPatientBloc>(
      () => _i30.GetPatientBloc(gh<_i15.PatientUsecase>()));
  gh.factory<_i31.HistoryBloc>(() => _i31.HistoryBloc(
        gh<_i25.BloodPressureUsecase>(),
        gh<_i29.BloodSugarUsecase>(),
        gh<_i19.TemperatureUsecase>(),
      ));
  gh.factory<_i32.OCRScannerBloc>(
      () => _i32.OCRScannerBloc(gh<_i25.BloodPressureUsecase>()));
  return getIt;
}

class _$DioProvider extends _i33.DioProvider {}

class _$AppModule extends _i33.AppModule {}
