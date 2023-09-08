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
    as _i14;
import '../common/service/local_manager/notification_datasource/notification_datasource.impl.dart'
    as _i15;
import '../common/service/local_manager/user_data_datasource/user_data_datasource.dart'
    as _i27;
import '../common/service/local_manager/user_data_datasource/user_data_datasource.impl.dart'
    as _i28;
import '../common/service/onesginal/onesignal_service.dart' as _i18;
import '../data/data_source/remote/module_repositories/blood_pressure_api_repository/blood_pressure_api_repository.dart'
    as _i29;
import '../data/data_source/remote/module_repositories/blood_pressure_api_repository/blood_pressure_api_repository_impl.dart'
    as _i30;
import '../data/data_source/remote/module_repositories/blood_sugar_api_repositoy/blood_sugar_api_repository.dart'
    as _i33;
import '../data/data_source/remote/module_repositories/blood_sugar_api_repositoy/blood_sugar_api_repository_impl.dart'
    as _i34;
import '../data/data_source/remote/module_repositories/doctor_infor_api_repository/doctor_api_repository.dart'
    as _i5;
import '../data/data_source/remote/module_repositories/doctor_infor_api_repository/doctor_api_repository_impl.dart'
    as _i6;
import '../data/data_source/remote/module_repositories/notification_onesignal_api_repository/notification_onesignal_api_repository.dart'
    as _i12;
import '../data/data_source/remote/module_repositories/notification_onesignal_api_repository/notification_onesignal_api_repository_impl.dart'
    as _i13;
import '../data/data_source/remote/module_repositories/patient_api_repository/patient_api_repository.dart'
    as _i19;
import '../data/data_source/remote/module_repositories/patient_api_repository/patient_api_repository_impl.dart'
    as _i20;
import '../data/data_source/remote/module_repositories/temperature_api_repository/temperature_api_repository.dart'
    as _i23;
import '../data/data_source/remote/module_repositories/temperature_api_repository/temperature_api_repository_impl.dart'
    as _i24;
import '../domain/repositories/blood_pressure_repository/blood_pressure_repository.dart'
    as _i31;
import '../domain/repositories/blood_sugar_repository/blood_sugar_repository.dart'
    as _i35;
import '../domain/repositories/doctor_infor_repository/doctor_infor_repository.dart'
    as _i7;
import '../domain/repositories/notification_onesignal_repository/notification_onesignal_repository.dart'
    as _i16;
import '../domain/repositories/patient_repository/patient_repository.dart'
    as _i21;
import '../domain/repositories/temperature_repository/temperature_repository.dart'
    as _i25;
import '../domain/usecases/blood_pressure_usecase/blood_pressure_usecase.dart'
    as _i32;
import '../domain/usecases/blood_sugar_usecase/blood_sugar_usecase.dart'
    as _i36;
import '../domain/usecases/doctor_infor_usecase/doctor_infor_usecase.dart'
    as _i8;
import '../domain/usecases/notification_onesignal_usecase/notification_onesignal_usecase.dart'
    as _i17;
import '../domain/usecases/patient_usecase/patient_usecase.dart' as _i22;
import '../domain/usecases/temperature_usecase/temperature_usecase.dart'
    as _i26;
import '../presentation/common_widget/image_picker/image_picker_bloc/image_picker_bloc.dart'
    as _i10;
import '../presentation/modules/camera_demo/camera_bloc/camera_bloc.dart'
    as _i3;
import '../presentation/modules/history/history_bloc/history_bloc.dart' as _i38;
import '../presentation/modules/login_screen/login/login_bloc.dart' as _i39;
import '../presentation/modules/notification_onesignal/bloc/notification_bloc.dart'
    as _i40;
import '../presentation/modules/OCR_scanner/ocr_scanner_bloc/ocr_scanner_bloc.dart'
    as _i41;
import '../presentation/modules/patient/bloc/get_patient_bloc.dart' as _i37;
import 'di.dart' as _i42;

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
  gh.factory<_i12.NotificationApiRepository>(
      () => _i13.NotificationApiRepositoryImpl(dio: gh<_i4.Dio>()));
  gh.factory<_i14.NotificationDataSource>(
      () => _i15.NotificationDataSourceImpl());
  gh.factory<_i16.NotificationRepository>(() =>
      _i16.NotificationListRepositoryImpl(
          gh<_i12.NotificationApiRepository>()));
  gh.factory<_i17.NotificationUsecase>(
      () => _i17.NotificationUsecaseImpl(gh<_i16.NotificationRepository>()));
  gh.singletonAsync<_i18.OneSignalNotificationService>(
      () => _i18.OneSignalNotificationService.create());
  gh.factory<_i19.PatientApiRepository>(
      () => _i20.PatientApiRepositoryImpl(dio: gh<_i4.Dio>()));
  gh.factory<_i21.PatientListRepository>(
      () => _i21.PatientListRepositoryImpl(gh<_i19.PatientApiRepository>()));
  gh.factory<_i22.PatientUsecase>(
      () => _i22.PatientUsecaseImpl(gh<_i21.PatientListRepository>()));
  gh.factory<_i23.TemperatureApiRepository>(
      () => _i24.TemperatureApiRepositoryImpl(dio: gh<_i4.Dio>()));
  gh.factory<_i25.TemperatureRepository>(() =>
      _i25.TemperatureRepositoryImpl(gh<_i23.TemperatureApiRepository>()));
  gh.factory<_i26.TemperatureUsecase>(
      () => _i26.TemperatureUsecaseImpl(gh<_i25.TemperatureRepository>()));
  gh.factory<_i27.UserDataDataSource>(() => _i28.UserDataDataSourceImpl());
  gh.factory<_i29.BloodPressureApiRepository>(
      () => _i30.BloodPressureApiRepositoryImpl(dio: gh<_i4.Dio>()));
  gh.factory<_i31.BloodPressureRepository>(() =>
      _i31.BloodPressureRepositoryImpl(gh<_i29.BloodPressureApiRepository>()));
  gh.factory<_i32.BloodPressureUsecase>(
      () => _i32.BloodPressureUsecaseImpl(gh<_i31.BloodPressureRepository>()));
  gh.factory<_i33.BloodSugarApiRepository>(
      () => _i34.BloodSugarApiRepositoryImpl(dio: gh<_i4.Dio>()));
  gh.factory<_i35.BloodSugarRepository>(
      () => _i35.BloodSugarRepositoryImpl(gh<_i33.BloodSugarApiRepository>()));
  gh.factory<_i36.BloodSugarUsecase>(
      () => _i36.BloodSugarUsecaseImpl(gh<_i35.BloodSugarRepository>()));
  gh.factory<_i37.GetPatientBloc>(() => _i37.GetPatientBloc(
        gh<_i22.PatientUsecase>(),
        gh<_i8.DoctorInforUsecase>(),
      ));
  gh.factory<_i38.HistoryBloc>(() => _i38.HistoryBloc(
        gh<_i32.BloodPressureUsecase>(),
        gh<_i36.BloodSugarUsecase>(),
        gh<_i26.TemperatureUsecase>(),
      ));
  gh.factory<_i39.LoginBloc>(() => _i39.LoginBloc(gh<_i22.PatientUsecase>()));
  gh.factory<_i40.NotificationBloc>(
      () => _i40.NotificationBloc(gh<_i17.NotificationUsecase>()));
  gh.factory<_i41.OCRScannerBloc>(() => _i41.OCRScannerBloc(
        gh<_i32.BloodPressureUsecase>(),
        gh<_i36.BloodSugarUsecase>(),
        gh<_i26.TemperatureUsecase>(),
      ));
  return getIt;
}

class _$DioProvider extends _i42.DioProvider {}

class _$AppModule extends _i42.AppModule {}
