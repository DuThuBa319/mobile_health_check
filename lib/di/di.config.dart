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

import '../common/service/firebase/firebase_auth_service.dart' as _i9;
import '../common/service/local_manager/local_data_manager.dart' as _i11;
import '../common/service/local_manager/notification_datasource/notification_datasource.dart'
    as _i13;
import '../common/service/local_manager/notification_datasource/notification_datasource.impl.dart'
    as _i14;
import '../common/service/local_manager/user_data_datasource/user_data_datasource.dart'
    as _i24;
import '../common/service/local_manager/user_data_datasource/user_data_datasource.impl.dart'
    as _i25;
import '../common/service/onesginal/bloc/notification_bloc.dart' as _i12;
import '../common/service/onesginal/onesignal_service.dart' as _i15;
import '../data/data_source/remote/module_repositories/blood_pressure_api_repository/blood_pressure_api_repository.dart'
    as _i26;
import '../data/data_source/remote/module_repositories/blood_pressure_api_repository/blood_pressure_api_repository_impl.dart'
    as _i27;
import '../data/data_source/remote/module_repositories/blood_sugar_api_repositoy/blood_sugar_api_repository.dart'
    as _i30;
import '../data/data_source/remote/module_repositories/blood_sugar_api_repositoy/blood_sugar_api_repository_impl.dart'
    as _i31;
import '../data/data_source/remote/module_repositories/doctor_infor_api_repository/doctor_api_repository.dart'
    as _i5;
import '../data/data_source/remote/module_repositories/doctor_infor_api_repository/doctor_api_repository_impl.dart'
    as _i6;
import '../data/data_source/remote/module_repositories/patient_api_repository/patient_api_repository.dart'
    as _i16;
import '../data/data_source/remote/module_repositories/patient_api_repository/patient_api_repository_impl.dart'
    as _i17;
import '../data/data_source/remote/module_repositories/temperature_api_repository/temperature_api_repository.dart'
    as _i20;
import '../data/data_source/remote/module_repositories/temperature_api_repository/temperature_api_repository_impl.dart'
    as _i21;
import '../domain/repositories/blood_pressure_repository/blood_pressure_repository.dart'
    as _i28;
import '../domain/repositories/blood_sugar_repository/blood_sugar_repository.dart'
    as _i32;
import '../domain/repositories/doctor_infor_repository/doctor_infor_repository.dart'
    as _i7;
import '../domain/repositories/patient_repository/patient_repository.dart'
    as _i18;
import '../domain/repositories/temperature_repository/temperature_repository.dart'
    as _i22;
import '../domain/usecases/blood_pressure_usecase/blood_pressure_usecase.dart'
    as _i29;
import '../domain/usecases/blood_sugar_usecase/blood_sugar_usecase.dart'
    as _i33;
import '../domain/usecases/doctor_infor_usecase/doctor_infor_usecase.dart'
    as _i8;
import '../domain/usecases/patient_usecase/patient_usecase.dart' as _i19;
import '../domain/usecases/temperature_usecase/temperature_usecase.dart'
    as _i23;
import '../presentation/common_widget/image_picker/image_picker_bloc/image_picker_bloc.dart'
    as _i10;
import '../presentation/modules/camera_demo/camera_bloc/camera_bloc.dart'
    as _i3;
import '../presentation/modules/history/history_bloc/history_bloc.dart' as _i35;
import '../presentation/modules/OCR_scanner/ocr_scanner_bloc/ocr_scanner_bloc.dart'
    as _i36;
import '../presentation/modules/patient/bloc/get_patient_bloc.dart' as _i34;
import 'di.dart' as _i37;

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
  gh.factory<_i5.DoctorInforApiRepository>(
      () => _i6.DoctorInforApiRepositoryImpl(dio: gh<_i4.Dio>()));
  gh.factory<_i7.DoctorInforRepository>(
      () => _i7.DoctorInforRepositoryImpl(gh<_i5.DoctorInforApiRepository>()));
  gh.factory<_i8.DoctorInforUsecase>(
      () => _i8.DoctorInforUsecaseImpl(gh<_i7.DoctorInforRepository>()));
  gh.singleton<_i9.FirebaseAuthService>(_i9.FirebaseAuthService());
  gh.factory<_i10.ImagePickerBloc>(() => _i10.ImagePickerBloc());
  gh.singletonAsync<_i11.LocalDataManager>(() => appModule.localDataManager);
  gh.factory<_i12.NotificationBloc>(() => _i12.NotificationBloc());
  gh.factory<_i13.NotificationDataSource>(
      () => _i14.NotificationDataSourceImpl());
  gh.singletonAsync<_i15.OneSignalNotificationService>(
      () => _i15.OneSignalNotificationService.create());
  gh.factory<_i16.PatientApiRepository>(
      () => _i17.PatientApiRepositoryImpl(dio: gh<_i4.Dio>()));
  gh.factory<_i18.PatientListRepository>(
      () => _i18.PatientListRepositoryImpl(gh<_i16.PatientApiRepository>()));
  gh.factory<_i19.PatientUsecase>(
      () => _i19.PatientUsecaseImpl(gh<_i18.PatientListRepository>()));
  gh.factory<_i20.TemperatureApiRepository>(
      () => _i21.TemperatureApiRepositoryImpl(dio: gh<_i4.Dio>()));
  gh.factory<_i22.TemperatureRepository>(() =>
      _i22.TemperatureRepositoryImpl(gh<_i20.TemperatureApiRepository>()));
  gh.factory<_i23.TemperatureUsecase>(
      () => _i23.TemperatureUsecaseImpl(gh<_i22.TemperatureRepository>()));
  gh.factory<_i24.UserDataDataSource>(() => _i25.UserDataDataSourceImpl());
  gh.factory<_i26.BloodPressureApiRepository>(
      () => _i27.BloodPressureApiRepositoryImpl(dio: gh<_i4.Dio>()));
  gh.factory<_i28.BloodPressureRepository>(() =>
      _i28.BloodPressureRepositoryImpl(gh<_i26.BloodPressureApiRepository>()));
  gh.factory<_i29.BloodPressureUsecase>(
      () => _i29.BloodPressureUsecaseImpl(gh<_i28.BloodPressureRepository>()));
  gh.factory<_i30.BloodSugarApiRepository>(
      () => _i31.BloodSugarApiRepositoryImpl(dio: gh<_i4.Dio>()));
  gh.factory<_i32.BloodSugarRepository>(
      () => _i32.BloodSugarRepositoryImpl(gh<_i30.BloodSugarApiRepository>()));
  gh.factory<_i33.BloodSugarUsecase>(
      () => _i33.BloodSugarUsecaseImpl(gh<_i32.BloodSugarRepository>()));
  gh.factory<_i34.GetPatientBloc>(
      () => _i34.GetPatientBloc(gh<_i19.PatientUsecase>()));
  gh.factory<_i35.HistoryBloc>(() => _i35.HistoryBloc(
        gh<_i29.BloodPressureUsecase>(),
        gh<_i33.BloodSugarUsecase>(),
        gh<_i23.TemperatureUsecase>(),
      ));
  gh.factory<_i36.OCRScannerBloc>(() => _i36.OCRScannerBloc(
        gh<_i29.BloodPressureUsecase>(),
        gh<_i33.BloodSugarUsecase>(),
        gh<_i23.TemperatureUsecase>(),
      ));
  return getIt;
}

class _$DioProvider extends _i37.DioProvider {}

class _$AppModule extends _i37.AppModule {}
