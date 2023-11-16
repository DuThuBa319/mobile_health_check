// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:connectivity_plus/connectivity_plus.dart' as _i63;
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
    as _i40;
import '../common/service/local_manager/user_data_datasource/user_data_datasource.impl.dart'
    as _i41;
import '../common/service/navigation/navigation_service.dart' as _i12;
import '../common/service/onesginal/onesignal_service.dart' as _i19;
import '../data/data_source/remote/module_repositories/admin_api_repository/admin_api_repository.dart'
    as _i42;
import '../data/data_source/remote/module_repositories/admin_api_repository/admin_api_repository_impl.dart'
    as _i43;
import '../data/data_source/remote/module_repositories/authentication_api_repository/authentication_api_repository.dart'
    as _i46;
import '../data/data_source/remote/module_repositories/authentication_api_repository/authentication_api_repository_impl.dart'
    as _i47;
import '../data/data_source/remote/module_repositories/blood_pressure_api_repository/blood_pressure_api_repository.dart'
    as _i50;
import '../data/data_source/remote/module_repositories/blood_pressure_api_repository/blood_pressure_api_repository_impl.dart'
    as _i51;
import '../data/data_source/remote/module_repositories/blood_sugar_api_repositoy/blood_sugar_api_repository.dart'
    as _i54;
import '../data/data_source/remote/module_repositories/blood_sugar_api_repositoy/blood_sugar_api_repository_impl.dart'
    as _i55;
import '../data/data_source/remote/module_repositories/change_pass_api_repository/change_pass_api_repository.dart'
    as _i58;
import '../data/data_source/remote/module_repositories/change_pass_api_repository/change_pass_api_repository_impl.dart'
    as _i59;
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
import '../data/data_source/remote/module_repositories/reset_password_api_repository/reset_password_api_repository.dart'
    as _i28;
import '../data/data_source/remote/module_repositories/reset_password_api_repository/reset_password_api_repository_impl.dart'
    as _i29;
import '../data/data_source/remote/module_repositories/spo2_api_repositoy/spo2_api_repository.dart'
    as _i32;
import '../data/data_source/remote/module_repositories/spo2_api_repositoy/spo2_api_repository_impl.dart'
    as _i33;
import '../data/data_source/remote/module_repositories/temperature_api_repository/temperature_api_repository.dart'
    as _i36;
import '../data/data_source/remote/module_repositories/temperature_api_repository/temperature_api_repository_impl.dart'
    as _i37;
import '../domain/repositories/admin_repository/admin_repository.dart' as _i44;
import '../domain/repositories/authentication_repository/authentication_repository.dart'
    as _i48;
import '../domain/repositories/blood_pressure_repository/blood_pressure_repository.dart'
    as _i52;
import '../domain/repositories/blood_sugar_repository/blood_sugar_repository.dart'
    as _i56;
import '../domain/repositories/change_pass_repository/change_pass_repository.dart'
    as _i60;
import '../domain/repositories/doctor_infor_repository/doctor_infor_repository.dart'
    as _i7;
import '../domain/repositories/notification_onesignal_repository/notification_onesignal_repository.dart'
    as _i17;
import '../domain/repositories/patient_repository/patient_repository.dart'
    as _i22;
import '../domain/repositories/relative_infor_repository/relative_infor_repository.dart'
    as _i26;
import '../domain/repositories/reset_password_repository/reset_password_repository.dart'
    as _i30;
import '../domain/repositories/spo2_repository/spo2_repository.dart' as _i34;
import '../domain/repositories/temperature_repository/temperature_repository.dart'
    as _i38;
import '../domain/usecases/admin_usecase/admin_usecase.dart' as _i45;
import '../domain/usecases/authentication_usecase/authentication_usecase.dart'
    as _i49;
import '../domain/usecases/blood_pressure_usecase/blood_pressure_usecase.dart'
    as _i53;
import '../domain/usecases/blood_sugar_usecase/blood_sugar_usecase.dart'
    as _i57;
import '../domain/usecases/change_pass_usecase/change_pass_usecase.dart'
    as _i61;
import '../domain/usecases/doctor_infor_usecase/doctor_infor_usecase.dart'
    as _i8;
import '../domain/usecases/notification_onesignal_usecase/notification_onesignal_usecase.dart'
    as _i18;
import '../domain/usecases/patient_usecase/patient_usecase.dart' as _i23;
import '../domain/usecases/relative_infor_usecase/relative_infor_usecase.dart'
    as _i27;
import '../domain/usecases/reset_password_usecase/reset_password_usecase.dart'
    as _i31;
import '../domain/usecases/spo2_usecase/spo2_usecase.dart' as _i35;
import '../domain/usecases/temperature_usecase/temperature_usecase.dart'
    as _i39;
import '../presentation/common_widget/image_picker/image_picker_bloc/image_picker_bloc.dart'
    as _i10;
import '../presentation/modules/admin_screen/bloc/get_doctor_bloc.dart' as _i62;
import '../presentation/modules/camera_demo/camera_bloc/camera_bloc.dart'
    as _i3;
import '../presentation/modules/history/history_bloc/history_bloc.dart' as _i65;
import '../presentation/modules/login_screen/login_bloc/login_bloc.dart'
    as _i66;
import '../presentation/modules/notification_onesignal/bloc/notification_bloc.dart'
    as _i67;
import '../presentation/modules/OCR_scanner/ocr_scanner_bloc/ocr_scanner_bloc.dart'
    as _i68;
import '../presentation/modules/patient_screen/bloc/get_patient_bloc.dart'
    as _i64;
import '../presentation/modules/setting_screen/setting_bloc/setting_bloc.dart'
    as _i69;
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
  gh.factory<_i28.ResetPasswordApiRepository>(
      () => _i29.ResetPasswordApiRepositoryImpl(dio: gh<_i4.Dio>()));
  gh.factory<_i30.ResetPasswordRepository>(() =>
      _i30.ResetPasswordRepositoryImpl(gh<_i28.ResetPasswordApiRepository>()));
  gh.factory<_i31.ResetPasswordUsecase>(
      () => _i31.ResetPasswordUsecaseImpl(gh<_i30.ResetPasswordRepository>()));
  gh.factory<_i32.Spo2ApiRepository>(
      () => _i33.Spo2ApiRepositoryImpl(dio: gh<_i4.Dio>()));
  gh.factory<_i34.Spo2Repository>(
      () => _i34.Spo2RepositoryImpl(gh<_i32.Spo2ApiRepository>()));
  gh.factory<_i35.Spo2Usecase>(
      () => _i35.Spo2UsecaseImpl(gh<_i34.Spo2Repository>()));
  gh.factory<_i36.TemperatureApiRepository>(
      () => _i37.TemperatureApiRepositoryImpl(dio: gh<_i4.Dio>()));
  gh.factory<_i38.TemperatureRepository>(() =>
      _i38.TemperatureRepositoryImpl(gh<_i36.TemperatureApiRepository>()));
  gh.factory<_i39.TemperatureUsecase>(
      () => _i39.TemperatureUsecaseImpl(gh<_i38.TemperatureRepository>()));
  gh.factory<_i40.UserDataDataSource>(() => _i41.UserDataDataSourceImpl());
  gh.factory<_i42.AdminApiRepository>(
      () => _i43.AdminApiRepositoryImpl(dio: gh<_i4.Dio>()));
  gh.factory<_i44.AdminRepository>(
      () => _i44.AdminRepositoryImpl(gh<_i42.AdminApiRepository>()));
  gh.factory<_i45.AdminUsecase>(
      () => _i45.AdminUsecaseImpl(gh<_i44.AdminRepository>()));
  gh.factory<_i46.AuthenApiRepository>(
      () => _i47.AuthenApiRepositoryImpl(dio: gh<_i4.Dio>()));
  gh.factory<_i48.AuthenRepository>(
      () => _i48.AuthenRepositoryImpl(gh<_i46.AuthenApiRepository>()));
  gh.factory<_i49.AuthenUsecase>(
      () => _i49.AuthenUsecaseImpl(gh<_i48.AuthenRepository>()));
  gh.factory<_i50.BloodPressureApiRepository>(
      () => _i51.BloodPressureApiRepositoryImpl(dio: gh<_i4.Dio>()));
  gh.factory<_i52.BloodPressureRepository>(() =>
      _i52.BloodPressureRepositoryImpl(gh<_i50.BloodPressureApiRepository>()));
  gh.factory<_i53.BloodPressureUsecase>(
      () => _i53.BloodPressureUsecaseImpl(gh<_i52.BloodPressureRepository>()));
  gh.factory<_i54.BloodSugarApiRepository>(
      () => _i55.BloodSugarApiRepositoryImpl(dio: gh<_i4.Dio>()));
  gh.factory<_i56.BloodSugarRepository>(
      () => _i56.BloodSugarRepositoryImpl(gh<_i54.BloodSugarApiRepository>()));
  gh.factory<_i57.BloodSugarUsecase>(
      () => _i57.BloodSugarUsecaseImpl(gh<_i56.BloodSugarRepository>()));
  gh.factory<_i58.ChangePassApiRepository>(
      () => _i59.ChangePassApiRepositoryImpl(dio: gh<_i4.Dio>()));
  gh.factory<_i60.ChangePassRepository>(
      () => _i60.ChangePassRepositoryImpl(gh<_i58.ChangePassApiRepository>()));
  gh.factory<_i61.ChangePassUsecase>(
      () => _i61.ChangePassUsecaseImpl(gh<_i60.ChangePassRepository>()));
  gh.factory<_i62.GetDoctorBloc>(() => _i62.GetDoctorBloc(
        gh<_i45.AdminUsecase>(),
        gh<_i8.DoctorInforUsecase>(),
        gh<_i63.Connectivity>(),
      ));
  gh.factory<_i64.GetPatientBloc>(() => _i64.GetPatientBloc(
        gh<_i45.AdminUsecase>(),
        gh<_i23.PatientUsecase>(),
        gh<_i8.DoctorInforUsecase>(),
        gh<_i27.RelativeInforUsecase>(),
        gh<_i63.Connectivity>(),
        gh<_i18.NotificationUsecase>(),
        gh<_i61.ChangePassUsecase>(),
      ));
  gh.factory<_i65.HistoryBloc>(() => _i65.HistoryBloc(
        gh<_i53.BloodPressureUsecase>(),
        gh<_i57.BloodSugarUsecase>(),
        gh<_i39.TemperatureUsecase>(),
        gh<_i35.Spo2Usecase>(),
        gh<_i63.Connectivity>(),
      ));
  gh.factory<_i66.LoginBloc>(() => _i66.LoginBloc(
        gh<_i23.PatientUsecase>(),
        gh<_i18.NotificationUsecase>(),
        gh<_i63.Connectivity>(),
        gh<_i49.AuthenUsecase>(),
        gh<_i31.ResetPasswordUsecase>(),
      ));
  gh.factory<_i67.NotificationBloc>(
      () => _i67.NotificationBloc(gh<_i18.NotificationUsecase>()));
  gh.factory<_i68.OCRScannerBloc>(() => _i68.OCRScannerBloc(
        gh<_i53.BloodPressureUsecase>(),
        gh<_i57.BloodSugarUsecase>(),
        gh<_i39.TemperatureUsecase>(),
        gh<_i35.Spo2Usecase>(),
      ));
  gh.factory<_i69.SettingBloc>(() => _i69.SettingBloc(
        gh<_i23.PatientUsecase>(),
        gh<_i8.DoctorInforUsecase>(),
        gh<_i27.RelativeInforUsecase>(),
        gh<_i63.Connectivity>(),
        gh<_i18.NotificationUsecase>(),
        gh<_i61.ChangePassUsecase>(),
      ));
  return getIt;
}

class _$DioProvider extends _i70.DioProvider {}

class _$AppModule extends _i70.AppModule {}
