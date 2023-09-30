// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:connectivity_plus/connectivity_plus.dart' as _i47;
import 'package:dio/dio.dart' as _i4;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../common/service/firebase/firebase_auth_service.dart' as _i9;
import '../common/service/local_manager/local_data_manager.dart' as _i11;
import '../common/service/local_manager/notification_datasource/notification_datasource.dart'
    as _i15;
import '../common/service/local_manager/notification_datasource/notification_datasource.impl.dart'
    as _i16;
import '../common/service/local_manager/user_data_datasource/user_data_datasource.dart'
    as _i36;
import '../common/service/local_manager/user_data_datasource/user_data_datasource.impl.dart'
    as _i37;
import '../common/service/navigation/navigation_service.dart' as _i12;
import '../common/service/onesginal/onesignal_service.dart' as _i19;
import '../data/data_source/remote/module_repositories/blood_pressure_api_repository/blood_pressure_api_repository.dart'
    as _i38;
import '../data/data_source/remote/module_repositories/blood_pressure_api_repository/blood_pressure_api_repository_impl.dart'
    as _i39;
import '../data/data_source/remote/module_repositories/blood_sugar_api_repositoy/blood_sugar_api_repository.dart'
    as _i42;
import '../data/data_source/remote/module_repositories/blood_sugar_api_repositoy/blood_sugar_api_repository_impl.dart'
    as _i43;
import '../data/data_source/remote/module_repositories/doctor_infor_api_repository/doctor_api_repository.dart'
    as _i5;
import '../data/data_source/remote/module_repositories/doctor_infor_api_repository/doctor_api_repository_impl.dart'
    as _i6;
import '../data/data_source/remote/module_repositories/notification_onesignal_api_repository/notification_onesignal_api_repository.dart'
    as _i13;
import '../data/data_source/remote/module_repositories/notification_onesignal_api_repository/notification_onesignal_api_repository_impl.dart'
    as _i14;
import '../data/data_source/remote/module_repositories/patient_api_repository/patient_api_repository.dart'
    as _i20;
import '../data/data_source/remote/module_repositories/patient_api_repository/patient_api_repository_impl.dart'
    as _i21;
import '../data/data_source/remote/module_repositories/relative_api_repository/relative_api_repository.dart'
    as _i24;
import '../data/data_source/remote/module_repositories/relative_api_repository/relative_api_repository_impl.dart'
    as _i25;
import '../data/data_source/remote/module_repositories/spo2_api_repositoy/spo2_api_repository.dart'
    as _i28;
import '../data/data_source/remote/module_repositories/spo2_api_repositoy/spo2_api_repository_impl.dart'
    as _i29;
import '../data/data_source/remote/module_repositories/temperature_api_repository/temperature_api_repository.dart'
    as _i32;
import '../data/data_source/remote/module_repositories/temperature_api_repository/temperature_api_repository_impl.dart'
    as _i33;
import '../domain/repositories/blood_pressure_repository/blood_pressure_repository.dart'
    as _i40;
import '../domain/repositories/blood_sugar_repository/blood_sugar_repository.dart'
    as _i44;
import '../domain/repositories/doctor_infor_repository/doctor_infor_repository.dart'
    as _i7;
import '../domain/repositories/notification_onesignal_repository/notification_onesignal_repository.dart'
    as _i17;
import '../domain/repositories/patient_repository/patient_repository.dart'
    as _i22;
import '../domain/repositories/relative_infor_repository/relative_infor_repository.dart'
    as _i26;
import '../domain/repositories/spo2_repository/spo2_repository.dart' as _i30;
import '../domain/repositories/temperature_repository/temperature_repository.dart'
    as _i34;
import '../domain/usecases/blood_pressure_usecase/blood_pressure_usecase.dart'
    as _i41;
import '../domain/usecases/blood_sugar_usecase/blood_sugar_usecase.dart'
    as _i45;
import '../domain/usecases/doctor_infor_usecase/doctor_infor_usecase.dart'
    as _i8;
import '../domain/usecases/notification_onesignal_usecase/notification_onesignal_usecase.dart'
    as _i18;
import '../domain/usecases/patient_usecase/patient_usecase.dart' as _i23;
import '../domain/usecases/relative_infor_usecase/relative_infor_usecase.dart'
    as _i27;
import '../domain/usecases/spo2_usecase/spo2_usecase.dart' as _i31;
import '../domain/usecases/temperature_usecase/temperature_usecase.dart'
    as _i35;
import '../presentation/common_widget/image_picker/image_picker_bloc/image_picker_bloc.dart'
    as _i10;
import '../presentation/modules/camera_demo/camera_bloc/camera_bloc.dart'
    as _i3;
import '../presentation/modules/history/history_bloc/history_bloc.dart' as _i48;
import '../presentation/modules/login_screen/login/login_bloc.dart' as _i49;
import '../presentation/modules/notification_onesignal/bloc/notification_bloc.dart'
    as _i50;
import '../presentation/modules/OCR_scanner/ocr_scanner_bloc/ocr_scanner_bloc.dart'
    as _i51;
import '../presentation/modules/patient/bloc/get_patient_bloc.dart' as _i46;
import 'di.dart' as _i52;

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
  gh.singleton<_i12.NavigationService>(appModule.navigationService);
  gh.factory<_i13.NotificationApiRepository>(
      () => _i14.NotificationApiRepositoryImpl(dio: gh<_i4.Dio>()));
  gh.factory<_i15.NotificationDataSource>(
      () => _i16.NotificationDataSourceImpl());
  gh.factory<_i17.NotificationRepository>(() =>
      _i17.NotificationListRepositoryImpl(
          gh<_i13.NotificationApiRepository>()));
  gh.factory<_i18.NotificationUsecase>(
      () => _i18.NotificationUsecaseImpl(gh<_i17.NotificationRepository>()));
  gh.singletonAsync<_i19.OneSignalNotificationService>(
      () => _i19.OneSignalNotificationService.create());
  gh.factory<_i20.PatientApiRepository>(
      () => _i21.PatientApiRepositoryImpl(dio: gh<_i4.Dio>()));
  gh.factory<_i22.PatientListRepository>(
      () => _i22.PatientListRepositoryImpl(gh<_i20.PatientApiRepository>()));
  gh.factory<_i23.PatientUsecase>(
      () => _i23.PatientUsecaseImpl(gh<_i22.PatientListRepository>()));
  gh.factory<_i24.RelativeInforApiRepository>(
      () => _i25.RelativeInforApiRepositoryImpl(dio: gh<_i4.Dio>()));
  gh.factory<_i26.RelativeInforRepository>(() =>
      _i26.RelativeInforRepositoryImpl(gh<_i24.RelativeInforApiRepository>()));
  gh.factory<_i27.RelativeInforUsecase>(
      () => _i27.RelativeInforUsecaseImpl(gh<_i26.RelativeInforRepository>()));
  gh.factory<_i28.Spo2ApiRepository>(
      () => _i29.Spo2ApiRepositoryImpl(dio: gh<_i4.Dio>()));
  gh.factory<_i30.Spo2Repository>(
      () => _i30.Spo2RepositoryImpl(gh<_i28.Spo2ApiRepository>()));
  gh.factory<_i31.Spo2Usecase>(
      () => _i31.Spo2UsecaseImpl(gh<_i30.Spo2Repository>()));
  gh.factory<_i32.TemperatureApiRepository>(
      () => _i33.TemperatureApiRepositoryImpl(dio: gh<_i4.Dio>()));
  gh.factory<_i34.TemperatureRepository>(() =>
      _i34.TemperatureRepositoryImpl(gh<_i32.TemperatureApiRepository>()));
  gh.factory<_i35.TemperatureUsecase>(
      () => _i35.TemperatureUsecaseImpl(gh<_i34.TemperatureRepository>()));
  gh.factory<_i36.UserDataDataSource>(() => _i37.UserDataDataSourceImpl());
  gh.factory<_i38.BloodPressureApiRepository>(
      () => _i39.BloodPressureApiRepositoryImpl(dio: gh<_i4.Dio>()));
  gh.factory<_i40.BloodPressureRepository>(() =>
      _i40.BloodPressureRepositoryImpl(gh<_i38.BloodPressureApiRepository>()));
  gh.factory<_i41.BloodPressureUsecase>(
      () => _i41.BloodPressureUsecaseImpl(gh<_i40.BloodPressureRepository>()));
  gh.factory<_i42.BloodSugarApiRepository>(
      () => _i43.BloodSugarApiRepositoryImpl(dio: gh<_i4.Dio>()));
  gh.factory<_i44.BloodSugarRepository>(
      () => _i44.BloodSugarRepositoryImpl(gh<_i42.BloodSugarApiRepository>()));
  gh.factory<_i45.BloodSugarUsecase>(
      () => _i45.BloodSugarUsecaseImpl(gh<_i44.BloodSugarRepository>()));
  gh.factory<_i46.GetPatientBloc>(() => _i46.GetPatientBloc(
        gh<_i23.PatientUsecase>(),
        gh<_i8.DoctorInforUsecase>(),
        gh<_i27.RelativeInforUsecase>(),
        gh<_i47.Connectivity>(),
      ));
  gh.factory<_i48.HistoryBloc>(() => _i48.HistoryBloc(
        gh<_i41.BloodPressureUsecase>(),
        gh<_i45.BloodSugarUsecase>(),
        gh<_i35.TemperatureUsecase>(),
        gh<_i31.Spo2Usecase>(),
        gh<_i47.Connectivity>(),
      ));
  gh.factory<_i49.LoginBloc>(() => _i49.LoginBloc(
        gh<_i23.PatientUsecase>(),
        gh<_i18.NotificationUsecase>(),
        gh<_i47.Connectivity>(),
      ));
  gh.factory<_i50.NotificationBloc>(
      () => _i50.NotificationBloc(gh<_i18.NotificationUsecase>()));
  gh.factory<_i51.OCRScannerBloc>(() => _i51.OCRScannerBloc(
        gh<_i41.BloodPressureUsecase>(),
        gh<_i45.BloodSugarUsecase>(),
        gh<_i35.TemperatureUsecase>(),
        gh<_i31.Spo2Usecase>(),
      ));
  return getIt;
}

class _$DioProvider extends _i52.DioProvider {}

class _$AppModule extends _i52.AppModule {}
