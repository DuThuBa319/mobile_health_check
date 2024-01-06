// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i5;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../common/service/firebase/firebase_auth_service.dart' as _i10;
import '../common/service/local_manager/local_data_manager.dart' as _i11;
import '../common/service/local_manager/notification_datasource/notification_datasource.dart'
    as _i16;
import '../common/service/local_manager/notification_datasource/notification_datasource.impl.dart'
    as _i17;
import '../common/service/local_manager/user_data_datasource/user_data_datasource.dart'
    as _i41;
import '../common/service/local_manager/user_data_datasource/user_data_datasource.impl.dart'
    as _i42;
import '../common/service/navigation/navigation_service.dart' as _i12;
import '../common/service/onesginal/onesignal_service.dart' as _i20;
import '../data/data_source/remote/module_repositories/admin_api_repository/admin_api_repository.dart'
    as _i43;
import '../data/data_source/remote/module_repositories/admin_api_repository/admin_api_repository_impl.dart'
    as _i44;
import '../data/data_source/remote/module_repositories/authentication_api_repository/authentication_api_repository.dart'
    as _i47;
import '../data/data_source/remote/module_repositories/authentication_api_repository/authentication_api_repository_impl.dart'
    as _i48;
import '../data/data_source/remote/module_repositories/blood_pressure_api_repository/blood_pressure_api_repository.dart'
    as _i51;
import '../data/data_source/remote/module_repositories/blood_pressure_api_repository/blood_pressure_api_repository_impl.dart'
    as _i52;
import '../data/data_source/remote/module_repositories/blood_sugar_api_repositoy/blood_sugar_api_repository.dart'
    as _i55;
import '../data/data_source/remote/module_repositories/blood_sugar_api_repositoy/blood_sugar_api_repository_impl.dart'
    as _i56;
import '../data/data_source/remote/module_repositories/change_pass_api_repository/change_pass_api_repository.dart'
    as _i59;
import '../data/data_source/remote/module_repositories/change_pass_api_repository/change_pass_api_repository_impl.dart'
    as _i60;
import '../data/data_source/remote/module_repositories/doctor_infor_api_repository/doctor_api_repository.dart'
    as _i6;
import '../data/data_source/remote/module_repositories/doctor_infor_api_repository/doctor_api_repository_impl.dart'
    as _i7;
import '../data/data_source/remote/module_repositories/notification_onesignal_api_repository/notification_onesignal_api_repository.dart'
    as _i14;
import '../data/data_source/remote/module_repositories/notification_onesignal_api_repository/notification_onesignal_api_repository_impl.dart'
    as _i15;
import '../data/data_source/remote/module_repositories/patient_api_repository/patient_api_repository.dart'
    as _i21;
import '../data/data_source/remote/module_repositories/patient_api_repository/patient_api_repository_impl.dart'
    as _i22;
import '../data/data_source/remote/module_repositories/relative_api_repository/relative_api_repository.dart'
    as _i25;
import '../data/data_source/remote/module_repositories/relative_api_repository/relative_api_repository_impl.dart'
    as _i26;
import '../data/data_source/remote/module_repositories/reset_password_api_repository/reset_password_api_repository.dart'
    as _i29;
import '../data/data_source/remote/module_repositories/reset_password_api_repository/reset_password_api_repository_impl.dart'
    as _i30;
import '../data/data_source/remote/module_repositories/spo2_api_repositoy/spo2_api_repository.dart'
    as _i33;
import '../data/data_source/remote/module_repositories/spo2_api_repositoy/spo2_api_repository_impl.dart'
    as _i34;
import '../data/data_source/remote/module_repositories/temperature_api_repository/temperature_api_repository.dart'
    as _i37;
import '../data/data_source/remote/module_repositories/temperature_api_repository/temperature_api_repository_impl.dart'
    as _i38;
import '../domain/network/network_info.dart' as _i13;
import '../domain/repositories/admin_repository/admin_repository.dart' as _i45;
import '../domain/repositories/authentication_repository/authentication_repository.dart'
    as _i49;
import '../domain/repositories/blood_pressure_repository/blood_pressure_repository.dart'
    as _i53;
import '../domain/repositories/blood_sugar_repository/blood_sugar_repository.dart'
    as _i57;
import '../domain/repositories/change_pass_repository/change_pass_repository.dart'
    as _i61;
import '../domain/repositories/doctor_infor_repository/doctor_infor_repository.dart'
    as _i8;
import '../domain/repositories/notification_onesignal_repository/notification_onesignal_repository.dart'
    as _i18;
import '../domain/repositories/patient_repository/patient_repository.dart'
    as _i23;
import '../domain/repositories/relative_infor_repository/relative_infor_repository.dart'
    as _i27;
import '../domain/repositories/reset_password_repository/reset_password_repository.dart'
    as _i31;
import '../domain/repositories/spo2_repository/spo2_repository.dart' as _i35;
import '../domain/repositories/temperature_repository/temperature_repository.dart'
    as _i39;
import '../domain/usecases/admin_usecase/admin_usecase.dart' as _i46;
import '../domain/usecases/authentication_usecase/authentication_usecase.dart'
    as _i50;
import '../domain/usecases/blood_pressure_usecase/blood_pressure_usecase.dart'
    as _i54;
import '../domain/usecases/blood_sugar_usecase/blood_sugar_usecase.dart'
    as _i58;
import '../domain/usecases/change_pass_usecase/change_pass_usecase.dart'
    as _i62;
import '../domain/usecases/doctor_infor_usecase/doctor_infor_usecase.dart'
    as _i9;
import '../domain/usecases/notification_onesignal_usecase/notification_onesignal_usecase.dart'
    as _i19;
import '../domain/usecases/patient_usecase/patient_usecase.dart' as _i24;
import '../domain/usecases/relative_infor_usecase/relative_infor_usecase.dart'
    as _i28;
import '../domain/usecases/reset_password_usecase/reset_password_usecase.dart'
    as _i32;
import '../domain/usecases/spo2_usecase/spo2_usecase.dart' as _i36;
import '../domain/usecases/temperature_usecase/temperature_usecase.dart'
    as _i40;
import '../presentation/modules/admin_screen/bloc/admin_bloc.dart' as _i63;
import '../presentation/modules/camera_demo/camera_bloc/camera_bloc.dart'
    as _i4;
import '../presentation/modules/history/history_bloc/history_bloc.dart' as _i65;
import '../presentation/modules/login_screen/bloc/login_bloc.dart' as _i66;
import '../presentation/modules/notification_onesignal/bloc/notification_bloc.dart'
    as _i67;
import '../presentation/modules/OCR_scanner/ocr_scanner_bloc/ocr_scanner_bloc.dart'
    as _i68;
import '../presentation/modules/patient_screen/bloc/get_patient_bloc.dart'
    as _i64;
import '../presentation/modules/setting_screen/setting_bloc/setting_bloc.dart'
    as _i69;
import '../utils/biometric_authentication.dart' as _i3;
import 'di.dart' as _i70;

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
  gh.singleton<_i3.BiometricAuthentication>(_i3.BiometricAuthentication());
  gh.factory<_i4.CameraBloc>(() => _i4.CameraBloc());
  gh.singleton<_i5.Dio>(dioProvider.dio());
  gh.factory<_i6.DoctorInforApiRepository>(
      () => _i7.DoctorInforApiRepositoryImpl(dio: gh<_i5.Dio>()));
  gh.factory<_i8.DoctorInforRepository>(
      () => _i8.DoctorInforRepositoryImpl(gh<_i6.DoctorInforApiRepository>()));
  gh.factory<_i9.DoctorInforUsecase>(
      () => _i9.DoctorInforUsecaseImpl(gh<_i8.DoctorInforRepository>()));
  gh.singleton<_i10.FirebaseAuthService>(_i10.FirebaseAuthService());
  gh.singletonAsync<_i11.LocalDataManager>(() => appModule.localDataManager);
  gh.singleton<_i12.NavigationService>(appModule.navigationService);
  gh.factory<_i13.NetworkInfo>(() => _i13.NetworkInfoImpl());
  gh.factory<_i14.NotificationApiRepository>(
      () => _i15.NotificationApiRepositoryImpl(dio: gh<_i5.Dio>()));
  gh.factory<_i16.NotificationDataSource>(
      () => _i17.NotificationDataSourceImpl());
  gh.factory<_i18.NotificationRepository>(() =>
      _i18.NotificationListRepositoryImpl(
          gh<_i14.NotificationApiRepository>()));
  gh.factory<_i19.NotificationUsecase>(
      () => _i19.NotificationUsecaseImpl(gh<_i18.NotificationRepository>()));
  gh.singletonAsync<_i20.OneSignalNotificationService>(
      () => _i20.OneSignalNotificationService.create());
  gh.factory<_i21.PatientApiRepository>(
      () => _i22.PatientApiRepositoryImpl(dio: gh<_i5.Dio>()));
  gh.factory<_i23.PatientListRepository>(
      () => _i23.PatientListRepositoryImpl(gh<_i21.PatientApiRepository>()));
  gh.factory<_i24.PatientUsecase>(
      () => _i24.PatientUsecaseImpl(gh<_i23.PatientListRepository>()));
  gh.factory<_i25.RelativeInforApiRepository>(
      () => _i26.RelativeInforApiRepositoryImpl(dio: gh<_i5.Dio>()));
  gh.factory<_i27.RelativeInforRepository>(() =>
      _i27.RelativeInforRepositoryImpl(gh<_i25.RelativeInforApiRepository>()));
  gh.factory<_i28.RelativeInforUsecase>(
      () => _i28.RelativeInforUsecaseImpl(gh<_i27.RelativeInforRepository>()));
  gh.factory<_i29.ResetPasswordApiRepository>(
      () => _i30.ResetPasswordApiRepositoryImpl(dio: gh<_i5.Dio>()));
  gh.factory<_i31.ResetPasswordRepository>(() =>
      _i31.ResetPasswordRepositoryImpl(gh<_i29.ResetPasswordApiRepository>()));
  gh.factory<_i32.ResetPasswordUsecase>(
      () => _i32.ResetPasswordUsecaseImpl(gh<_i31.ResetPasswordRepository>()));
  gh.factory<_i33.Spo2ApiRepository>(
      () => _i34.Spo2ApiRepositoryImpl(dio: gh<_i5.Dio>()));
  gh.factory<_i35.Spo2Repository>(
      () => _i35.Spo2RepositoryImpl(gh<_i33.Spo2ApiRepository>()));
  gh.factory<_i36.Spo2Usecase>(
      () => _i36.Spo2UsecaseImpl(gh<_i35.Spo2Repository>()));
  gh.factory<_i37.TemperatureApiRepository>(
      () => _i38.TemperatureApiRepositoryImpl(dio: gh<_i5.Dio>()));
  gh.factory<_i39.TemperatureRepository>(() =>
      _i39.TemperatureRepositoryImpl(gh<_i37.TemperatureApiRepository>()));
  gh.factory<_i40.TemperatureUsecase>(
      () => _i40.TemperatureUsecaseImpl(gh<_i39.TemperatureRepository>()));
  gh.factory<_i41.UserDataDataSource>(() => _i42.UserDataDataSourceImpl());
  gh.factory<_i43.AdminApiRepository>(
      () => _i44.AdminApiRepositoryImpl(dio: gh<_i5.Dio>()));
  gh.factory<_i45.AdminRepository>(
      () => _i45.AdminRepositoryImpl(gh<_i43.AdminApiRepository>()));
  gh.factory<_i46.AdminUsecase>(
      () => _i46.AdminUsecaseImpl(gh<_i45.AdminRepository>()));
  gh.factory<_i47.AuthenApiRepository>(
      () => _i48.AuthenApiRepositoryImpl(dio: gh<_i5.Dio>()));
  gh.factory<_i49.AuthenRepository>(
      () => _i49.AuthenRepositoryImpl(gh<_i47.AuthenApiRepository>()));
  gh.factory<_i50.AuthenUsecase>(
      () => _i50.AuthenUsecaseImpl(gh<_i49.AuthenRepository>()));
  gh.factory<_i51.BloodPressureApiRepository>(
      () => _i52.BloodPressureApiRepositoryImpl(dio: gh<_i5.Dio>()));
  gh.factory<_i53.BloodPressureRepository>(() =>
      _i53.BloodPressureRepositoryImpl(gh<_i51.BloodPressureApiRepository>()));
  gh.factory<_i54.BloodPressureUsecase>(
      () => _i54.BloodPressureUsecaseImpl(gh<_i53.BloodPressureRepository>()));
  gh.factory<_i55.BloodSugarApiRepository>(
      () => _i56.BloodSugarApiRepositoryImpl(dio: gh<_i5.Dio>()));
  gh.factory<_i57.BloodSugarRepository>(
      () => _i57.BloodSugarRepositoryImpl(gh<_i55.BloodSugarApiRepository>()));
  gh.factory<_i58.BloodSugarUsecase>(
      () => _i58.BloodSugarUsecaseImpl(gh<_i57.BloodSugarRepository>()));
  gh.factory<_i59.ChangePassApiRepository>(
      () => _i60.ChangePassApiRepositoryImpl(dio: gh<_i5.Dio>()));
  gh.factory<_i61.ChangePassRepository>(
      () => _i61.ChangePassRepositoryImpl(gh<_i59.ChangePassApiRepository>()));
  gh.factory<_i62.ChangePassUsecase>(
      () => _i62.ChangePassUsecaseImpl(gh<_i61.ChangePassRepository>()));
  gh.factory<_i63.GetDoctorBloc>(() => _i63.GetDoctorBloc(
        gh<_i46.AdminUsecase>(),
        gh<_i9.DoctorInforUsecase>(),
        gh<_i13.NetworkInfo>(),
      ));
  gh.factory<_i64.GetPatientBloc>(() => _i64.GetPatientBloc(
        gh<_i13.NetworkInfo>(),
        gh<_i46.AdminUsecase>(),
        gh<_i24.PatientUsecase>(),
        gh<_i9.DoctorInforUsecase>(),
        gh<_i28.RelativeInforUsecase>(),
        gh<_i19.NotificationUsecase>(),
        gh<_i62.ChangePassUsecase>(),
      ));
  gh.factory<_i65.HistoryBloc>(() => _i65.HistoryBloc(
        gh<_i54.BloodPressureUsecase>(),
        gh<_i58.BloodSugarUsecase>(),
        gh<_i13.NetworkInfo>(),
        gh<_i40.TemperatureUsecase>(),
        gh<_i36.Spo2Usecase>(),
      ));
  gh.factory<_i66.LoginBloc>(() => _i66.LoginBloc(
        gh<_i24.PatientUsecase>(),
        gh<_i19.NotificationUsecase>(),
        gh<_i13.NetworkInfo>(),
        gh<_i50.AuthenUsecase>(),
        gh<_i32.ResetPasswordUsecase>(),
      ));
  gh.factory<_i67.NotificationBloc>(
      () => _i67.NotificationBloc(gh<_i19.NotificationUsecase>()));
  gh.factory<_i68.OCRScannerBloc>(() => _i68.OCRScannerBloc(
        gh<_i13.NetworkInfo>(),
        gh<_i54.BloodPressureUsecase>(),
        gh<_i58.BloodSugarUsecase>(),
        gh<_i40.TemperatureUsecase>(),
        gh<_i36.Spo2Usecase>(),
      ));
  gh.factory<_i69.SettingBloc>(() => _i69.SettingBloc(
        gh<_i13.NetworkInfo>(),
        gh<_i24.PatientUsecase>(),
        gh<_i9.DoctorInforUsecase>(),
        gh<_i28.RelativeInforUsecase>(),
        gh<_i19.NotificationUsecase>(),
        gh<_i62.ChangePassUsecase>(),
      ));
  return getIt;
}

class _$DioProvider extends _i70.DioProvider {}

class _$AppModule extends _i70.AppModule {}
