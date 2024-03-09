// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:connectivity_plus/connectivity_plus.dart' as _i5;
import 'package:dio/dio.dart' as _i6;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../common/service/firebase/firebase_auth_service.dart' as _i11;
import '../common/service/local_manager/local_data_manager.dart' as _i12;
import '../common/service/local_manager/notification_datasource/notification_datasource.dart'
    as _i17;
import '../common/service/local_manager/notification_datasource/notification_datasource.impl.dart'
    as _i18;
import '../common/service/local_manager/user_data_datasource/user_data_datasource.dart'
    as _i42;
import '../common/service/local_manager/user_data_datasource/user_data_datasource.impl.dart'
    as _i43;
import '../common/service/navigation/navigation_service.dart' as _i13;
import '../common/service/onesginal/onesignal_service.dart' as _i21;
import '../data/data_source/remote/module_repositories/admin_api_repository/admin_api_repository.dart'
    as _i44;
import '../data/data_source/remote/module_repositories/admin_api_repository/admin_api_repository_impl.dart'
    as _i45;
import '../data/data_source/remote/module_repositories/authentication_api_repository/authentication_api_repository.dart'
    as _i48;
import '../data/data_source/remote/module_repositories/authentication_api_repository/authentication_api_repository_impl.dart'
    as _i49;
import '../data/data_source/remote/module_repositories/blood_pressure_api_repository/blood_pressure_api_repository.dart'
    as _i52;
import '../data/data_source/remote/module_repositories/blood_pressure_api_repository/blood_pressure_api_repository_impl.dart'
    as _i53;
import '../data/data_source/remote/module_repositories/blood_sugar_api_repositoy/blood_sugar_api_repository.dart'
    as _i56;
import '../data/data_source/remote/module_repositories/blood_sugar_api_repositoy/blood_sugar_api_repository_impl.dart'
    as _i57;
import '../data/data_source/remote/module_repositories/change_pass_api_repository/change_pass_api_repository.dart'
    as _i60;
import '../data/data_source/remote/module_repositories/change_pass_api_repository/change_pass_api_repository_impl.dart'
    as _i61;
import '../data/data_source/remote/module_repositories/doctor_infor_api_repository/doctor_api_repository.dart'
    as _i7;
import '../data/data_source/remote/module_repositories/doctor_infor_api_repository/doctor_api_repository_impl.dart'
    as _i8;
import '../data/data_source/remote/module_repositories/notification_onesignal_api_repository/notification_onesignal_api_repository.dart'
    as _i15;
import '../data/data_source/remote/module_repositories/notification_onesignal_api_repository/notification_onesignal_api_repository_impl.dart'
    as _i16;
import '../data/data_source/remote/module_repositories/patient_api_repository/patient_api_repository.dart'
    as _i22;
import '../data/data_source/remote/module_repositories/patient_api_repository/patient_api_repository_impl.dart'
    as _i23;
import '../data/data_source/remote/module_repositories/relative_api_repository/relative_api_repository.dart'
    as _i26;
import '../data/data_source/remote/module_repositories/relative_api_repository/relative_api_repository_impl.dart'
    as _i27;
import '../data/data_source/remote/module_repositories/reset_password_api_repository/reset_password_api_repository.dart'
    as _i30;
import '../data/data_source/remote/module_repositories/reset_password_api_repository/reset_password_api_repository_impl.dart'
    as _i31;
import '../data/data_source/remote/module_repositories/spo2_api_repositoy/spo2_api_repository.dart'
    as _i34;
import '../data/data_source/remote/module_repositories/spo2_api_repositoy/spo2_api_repository_impl.dart'
    as _i35;
import '../data/data_source/remote/module_repositories/temperature_api_repository/temperature_api_repository.dart'
    as _i38;
import '../data/data_source/remote/module_repositories/temperature_api_repository/temperature_api_repository_impl.dart'
    as _i39;
import '../domain/network/network_info.dart' as _i14;
import '../domain/repositories/admin_repository/admin_repository.dart' as _i46;
import '../domain/repositories/authentication_repository/authentication_repository.dart'
    as _i50;
import '../domain/repositories/blood_pressure_repository/blood_pressure_repository.dart'
    as _i54;
import '../domain/repositories/blood_sugar_repository/blood_sugar_repository.dart'
    as _i58;
import '../domain/repositories/change_pass_repository/change_pass_repository.dart'
    as _i62;
import '../domain/repositories/doctor_infor_repository/doctor_infor_repository.dart'
    as _i9;
import '../domain/repositories/notification_onesignal_repository/notification_onesignal_repository.dart'
    as _i19;
import '../domain/repositories/patient_repository/patient_repository.dart'
    as _i24;
import '../domain/repositories/relative_infor_repository/relative_infor_repository.dart'
    as _i28;
import '../domain/repositories/reset_password_repository/reset_password_repository.dart'
    as _i32;
import '../domain/repositories/spo2_repository/spo2_repository.dart' as _i36;
import '../domain/repositories/temperature_repository/temperature_repository.dart'
    as _i40;
import '../domain/usecases/admin_usecase/admin_usecase.dart' as _i47;
import '../domain/usecases/authentication_usecase/authentication_usecase.dart'
    as _i51;
import '../domain/usecases/blood_pressure_usecase/blood_pressure_usecase.dart'
    as _i55;
import '../domain/usecases/blood_sugar_usecase/blood_sugar_usecase.dart'
    as _i59;
import '../domain/usecases/change_pass_usecase/change_pass_usecase.dart'
    as _i63;
import '../domain/usecases/doctor_infor_usecase/doctor_infor_usecase.dart'
    as _i10;
import '../domain/usecases/notification_onesignal_usecase/notification_onesignal_usecase.dart'
    as _i20;
import '../domain/usecases/patient_usecase/patient_usecase.dart' as _i25;
import '../domain/usecases/relative_infor_usecase/relative_infor_usecase.dart'
    as _i29;
import '../domain/usecases/reset_password_usecase/reset_password_usecase.dart'
    as _i33;
import '../domain/usecases/spo2_usecase/spo2_usecase.dart' as _i37;
import '../domain/usecases/temperature_usecase/temperature_usecase.dart'
    as _i41;
import '../presentation/modules/admin_screen/bloc/admin_bloc.dart' as _i64;
import '../presentation/modules/camera_demo/camera_bloc/camera_bloc.dart'
    as _i4;
import '../presentation/modules/history/history_bloc/history_bloc.dart' as _i66;
import '../presentation/modules/login_screen/bloc/login_bloc.dart' as _i67;
import '../presentation/modules/notification_onesignal/bloc/notification_bloc.dart'
    as _i68;
import '../presentation/modules/OCR_scanner/ocr_scanner_bloc/ocr_scanner_bloc.dart'
    as _i69;
import '../presentation/modules/patient_screen/bloc/get_patient_bloc.dart'
    as _i65;
import '../presentation/modules/setting_screen/setting_bloc/setting_bloc.dart'
    as _i70;
import '../utils/biometric_authentication.dart' as _i3;
import 'di.dart' as _i71;

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
  final appModule = _$AppModule();
  final dioProvider = _$DioProvider();
  gh.singleton<_i3.BiometricAuthentication>(_i3.BiometricAuthentication());
  gh.factory<_i4.CameraBloc>(() => _i4.CameraBloc());
  gh.singleton<_i5.Connectivity>(appModule.connectivity);
  gh.singleton<_i6.Dio>(dioProvider.dio());
  gh.factory<_i7.DoctorInforApiRepository>(
      () => _i8.DoctorInforApiRepositoryImpl(dio: gh<_i6.Dio>()));
  gh.factory<_i9.DoctorInforRepository>(
      () => _i9.DoctorInforRepositoryImpl(gh<_i7.DoctorInforApiRepository>()));
  gh.factory<_i10.DoctorInforUsecase>(
      () => _i10.DoctorInforUsecaseImpl(gh<_i9.DoctorInforRepository>()));
  gh.singleton<_i11.FirebaseAuthService>(_i11.FirebaseAuthService());
  gh.singletonAsync<_i12.LocalDataManager>(() => appModule.localDataManager);
  gh.singleton<_i13.NavigationService>(_i13.NavigationService());
  gh.factory<_i14.NetworkInfo>(() => _i14.NetworkInfoImpl());
  gh.factory<_i15.NotificationApiRepository>(
      () => _i16.NotificationApiRepositoryImpl(dio: gh<_i6.Dio>()));
  gh.factory<_i17.NotificationDataSource>(
      () => _i18.NotificationDataSourceImpl());
  gh.factory<_i19.NotificationRepository>(() =>
      _i19.NotificationListRepositoryImpl(
          gh<_i15.NotificationApiRepository>()));
  gh.factory<_i20.NotificationUsecase>(
      () => _i20.NotificationUsecaseImpl(gh<_i19.NotificationRepository>()));
  gh.singletonAsync<_i21.OneSignalNotificationService>(
      () => _i21.OneSignalNotificationService.create());
  gh.factory<_i22.PatientApiRepository>(
      () => _i23.PatientApiRepositoryImpl(dio: gh<_i6.Dio>()));
  gh.factory<_i24.PatientListRepository>(
      () => _i24.PatientListRepositoryImpl(gh<_i22.PatientApiRepository>()));
  gh.factory<_i25.PatientUsecase>(
      () => _i25.PatientUsecaseImpl(gh<_i24.PatientListRepository>()));
  gh.factory<_i26.RelativeInforApiRepository>(
      () => _i27.RelativeInforApiRepositoryImpl(dio: gh<_i6.Dio>()));
  gh.factory<_i28.RelativeInforRepository>(() =>
      _i28.RelativeInforRepositoryImpl(gh<_i26.RelativeInforApiRepository>()));
  gh.factory<_i29.RelativeInforUsecase>(
      () => _i29.RelativeInforUsecaseImpl(gh<_i28.RelativeInforRepository>()));
  gh.factory<_i30.ResetPasswordApiRepository>(
      () => _i31.ResetPasswordApiRepositoryImpl(dio: gh<_i6.Dio>()));
  gh.factory<_i32.ResetPasswordRepository>(() =>
      _i32.ResetPasswordRepositoryImpl(gh<_i30.ResetPasswordApiRepository>()));
  gh.factory<_i33.ResetPasswordUsecase>(
      () => _i33.ResetPasswordUsecaseImpl(gh<_i32.ResetPasswordRepository>()));
  gh.factory<_i34.Spo2ApiRepository>(
      () => _i35.Spo2ApiRepositoryImpl(dio: gh<_i6.Dio>()));
  gh.factory<_i36.Spo2Repository>(
      () => _i36.Spo2RepositoryImpl(gh<_i34.Spo2ApiRepository>()));
  gh.factory<_i37.Spo2Usecase>(
      () => _i37.Spo2UsecaseImpl(gh<_i36.Spo2Repository>()));
  gh.factory<_i38.TemperatureApiRepository>(
      () => _i39.TemperatureApiRepositoryImpl(dio: gh<_i6.Dio>()));
  gh.factory<_i40.TemperatureRepository>(() =>
      _i40.TemperatureRepositoryImpl(gh<_i38.TemperatureApiRepository>()));
  gh.factory<_i41.TemperatureUsecase>(
      () => _i41.TemperatureUsecaseImpl(gh<_i40.TemperatureRepository>()));
  gh.factory<_i42.UserDataDataSource>(() => _i43.UserDataDataSourceImpl());
  gh.factory<_i44.AdminApiRepository>(
      () => _i45.AdminApiRepositoryImpl(dio: gh<_i6.Dio>()));
  gh.factory<_i46.AdminRepository>(
      () => _i46.AdminRepositoryImpl(gh<_i44.AdminApiRepository>()));
  gh.factory<_i47.AdminUsecase>(
      () => _i47.AdminUsecaseImpl(gh<_i46.AdminRepository>()));
  gh.factory<_i48.AuthenApiRepository>(
      () => _i49.AuthenApiRepositoryImpl(dio: gh<_i6.Dio>()));
  gh.factory<_i50.AuthenRepository>(
      () => _i50.AuthenRepositoryImpl(gh<_i48.AuthenApiRepository>()));
  gh.factory<_i51.AuthenUsecase>(
      () => _i51.AuthenUsecaseImpl(gh<_i50.AuthenRepository>()));
  gh.factory<_i52.BloodPressureApiRepository>(
      () => _i53.BloodPressureApiRepositoryImpl(dio: gh<_i6.Dio>()));
  gh.factory<_i54.BloodPressureRepository>(() =>
      _i54.BloodPressureRepositoryImpl(gh<_i52.BloodPressureApiRepository>()));
  gh.factory<_i55.BloodPressureUsecase>(
      () => _i55.BloodPressureUsecaseImpl(gh<_i54.BloodPressureRepository>()));
  gh.factory<_i56.BloodSugarApiRepository>(
      () => _i57.BloodSugarApiRepositoryImpl(dio: gh<_i6.Dio>()));
  gh.factory<_i58.BloodSugarRepository>(
      () => _i58.BloodSugarRepositoryImpl(gh<_i56.BloodSugarApiRepository>()));
  gh.factory<_i59.BloodSugarUsecase>(
      () => _i59.BloodSugarUsecaseImpl(gh<_i58.BloodSugarRepository>()));
  gh.factory<_i60.ChangePassApiRepository>(
      () => _i61.ChangePassApiRepositoryImpl(dio: gh<_i6.Dio>()));
  gh.factory<_i62.ChangePassRepository>(
      () => _i62.ChangePassRepositoryImpl(gh<_i60.ChangePassApiRepository>()));
  gh.factory<_i63.ChangePassUsecase>(
      () => _i63.ChangePassUsecaseImpl(gh<_i62.ChangePassRepository>()));
  gh.factory<_i64.GetDoctorBloc>(() => _i64.GetDoctorBloc(
        gh<_i47.AdminUsecase>(),
        gh<_i10.DoctorInforUsecase>(),
        gh<_i14.NetworkInfo>(),
      ));
  gh.factory<_i65.GetPatientBloc>(() => _i65.GetPatientBloc(
        gh<_i14.NetworkInfo>(),
        gh<_i25.PatientUsecase>(),
        gh<_i10.DoctorInforUsecase>(),
        gh<_i29.RelativeInforUsecase>(),
        gh<_i20.NotificationUsecase>(),
        gh<_i63.ChangePassUsecase>(),
      ));
  gh.factory<_i66.HistoryBloc>(() => _i66.HistoryBloc(
        gh<_i55.BloodPressureUsecase>(),
        gh<_i59.BloodSugarUsecase>(),
        gh<_i14.NetworkInfo>(),
        gh<_i41.TemperatureUsecase>(),
        gh<_i37.Spo2Usecase>(),
      ));
  gh.factory<_i67.LoginBloc>(() => _i67.LoginBloc(
        gh<_i25.PatientUsecase>(),
        gh<_i20.NotificationUsecase>(),
        gh<_i14.NetworkInfo>(),
        gh<_i51.AuthenUsecase>(),
        gh<_i33.ResetPasswordUsecase>(),
      ));
  gh.factory<_i68.NotificationBloc>(() => _i68.NotificationBloc(
        gh<_i20.NotificationUsecase>(),
        gh<_i14.NetworkInfo>(),
      ));
  gh.factory<_i69.OCRScannerBloc>(() => _i69.OCRScannerBloc(
        gh<_i14.NetworkInfo>(),
        gh<_i55.BloodPressureUsecase>(),
        gh<_i25.PatientUsecase>(),
        gh<_i59.BloodSugarUsecase>(),
        gh<_i41.TemperatureUsecase>(),
        gh<_i37.Spo2Usecase>(),
      ));
  gh.factory<_i70.SettingBloc>(() => _i70.SettingBloc(
        gh<_i14.NetworkInfo>(),
        gh<_i25.PatientUsecase>(),
        gh<_i10.DoctorInforUsecase>(),
        gh<_i29.RelativeInforUsecase>(),
        gh<_i20.NotificationUsecase>(),
        gh<_i63.ChangePassUsecase>(),
      ));
  return getIt;
}

class _$AppModule extends _i71.AppModule {}

class _$DioProvider extends _i71.DioProvider {}
