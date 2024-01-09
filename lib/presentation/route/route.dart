import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:mobile_health_check/domain/entities/patient_infor_entity.dart';
import 'package:mobile_health_check/presentation/modules/OCR_scanner/ocr_scanner_bloc/ocr_scanner_bloc.dart';
import 'package:mobile_health_check/presentation/modules/OCR_scanner/blood_pressure_reading_screen.dart';
import 'package:mobile_health_check/presentation/modules/camera_demo/camera_demo_screen.dart';

import 'package:mobile_health_check/presentation/modules/history/temperature_history_screen/temperature_history_screen.dart';

import 'package:mobile_health_check/presentation/modules/login_screen/login_screen.dart';
import 'package:mobile_health_check/presentation/modules/patient_screen/patient_profile/add_relative_screen.dart';
import 'package:mobile_health_check/presentation/modules/pick_equipment/pick_equipment_screen.dart';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/blood_pressure_entity.dart';
import '../../domain/entities/blood_sugar_entity.dart';
import '../../domain/entities/spo2_entity.dart';
import '../../domain/entities/temperature_entity.dart';
import '../common_widget/enum_common.dart';

import '../modules/OCR_scanner/blood_glucose_reading_screen.dart';
import '../modules/OCR_scanner/spo2_reading_screen.dart';
import '../modules/OCR_scanner/temperature_reading_screen.dart';
import '../modules/admin_screen/bloc/admin_bloc.dart';
import '../modules/admin_screen/doctor_list/doctor_list_screen.dart';
import '../modules/admin_screen/doctor_list/widget/add_doctor_screen.dart';
import '../modules/admin_screen/doctor_profile/doctor_infor_screen.dart';
import '../modules/camera_demo/camera_bloc/camera_bloc.dart';
import '../modules/history/blood_pressure_history_screen/blood_pressure_history_screen.dart';
import '../modules/history/blood_sugar_history_screen/blood_sugar_history_screen.dart';
import '../modules/history/detail_screen/blood_pressure_detail.dart';
import '../modules/history/detail_screen/blood_sugar_detail.dart';
import '../modules/history/detail_screen/spo2_detail.dart';
import '../modules/history/detail_screen/temperature_detail.dart';
import '../modules/history/history_bloc/history_bloc.dart';
import '../modules/history/spo2_history_screen/spo2_history_screen.dart';
import '../modules/login_screen/forgot_pass_screen/forgot_password_screen.dart';
import '../modules/login_screen/bloc/login_bloc.dart';
import '../modules/notification_onesignal/bloc/notification_bloc.dart';
import '../modules/notification_onesignal/detail_screen/blood_pressure_reading.dart';
import '../modules/notification_onesignal/detail_screen/blood_sugar_reading.dart';
import '../modules/notification_onesignal/detail_screen/spo2_reading.dart';
import '../modules/notification_onesignal/detail_screen/temperature_reading.dart';
import '../modules/notification_onesignal/notification_screen.dart';

import '../modules/patient_screen/bloc/get_patient_bloc.dart';
import '../modules/patient_screen/patient_list/patients_list_screen.dart';
import '../modules/patient_screen/patient_list/widget/add_patient_screen.dart';
import '../modules/patient_screen/patient_profile/patient_infor_screen.dart';
import '../modules/patient_screen/patient_profile/widget/patient_infor_cell.dart';
import '../modules/setting_screen/language_setting.dart';
import '../modules/setting_screen/password_setting.dart';
import '../modules/setting_screen/setting_menu.dart';
import '../modules/setting_screen/profile_setting.dart';
import '../modules/setting_screen/setting_bloc/setting_bloc.dart';

class AppRoute {
  static GetIt getIt = GetIt.instance;
  static Connectivity connectivity = getIt<Connectivity>();

  static Route onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/patientInfor':
        final patientId = routeSettings.arguments as String;
        return MaterialPageRoute(
          builder: (context) {
            return BlocProvider<GetPatientBloc>(
              create: (context) => getIt<GetPatientBloc>(),
              child: PatientInforScreen(patientId: patientId),
            );
          },
        );

      case '/doctorInfor':
        final doctorId = routeSettings.arguments as String;
        return MaterialPageRoute(
          builder: (context) {
            return BlocProvider<GetDoctorBloc>(
              create: (context) => getIt<GetDoctorBloc>(),
              child: DoctorInforScreen(doctorId: doctorId),
            );
          },
        );

      case '/patientInforCell':
        final response = routeSettings.arguments as PatientInforEntity;
        return MaterialPageRoute(
            builder: (context) => PatientInforCell(
                  patientInforEntity: response,
                ));
      case '/camera':
        final measuringTask = routeSettings.arguments as MeasuringTask;
        return MaterialPageRoute(
          builder: (context) {
            return BlocProvider<CameraBloc>(
              create: (context) => getIt<CameraBloc>(),
              child: CameraScreen(task: measuringTask),
            );
          },
        );
      case '/login':
        return MaterialPageRoute(
          builder: (context) {
            return BlocProvider<LoginBloc>(
              create: (context) => getIt<LoginBloc>(),
              child: const LoginScreen(),
            );
          },
        );
      case '/forgotPass':
        return MaterialPageRoute(
          builder: (context) {
            return BlocProvider<LoginBloc>(
              create: (context) => getIt<LoginBloc>(),
              child: const ForgotPassScreen(),
            );
          },
        );

      case '/patient_list':
        final id = routeSettings.arguments as String;
        return MaterialPageRoute(
          builder: (context) {
            return BlocProvider<GetPatientBloc>(
              create: (context) => getIt<GetPatientBloc>(),
              child: PatientListScreen(id: id),
            );
          },
        );
      case '/doctor_list':
        final id = routeSettings.arguments as String;
        return MaterialPageRoute(
          builder: (context) {
            return BlocProvider<GetDoctorBloc>(
              create: (context) => getIt<GetDoctorBloc>(),
              child: DoctorListScreen(id: id),
            );
          },
        );

      case '/addRelative':
        final patientId = routeSettings.arguments as String;
        return MaterialPageRoute(
          builder: (context) {
            return BlocProvider<GetPatientBloc>(
              create: (context) => getIt<GetPatientBloc>(),
              child: AddRelativeScreen(patientId: patientId),
            );
          },
        );
      case '/addPatient':
        return MaterialPageRoute(
          builder: (context) {
            return BlocProvider<GetPatientBloc>(
              create: (context) => getIt<GetPatientBloc>(),
              child: const AddPatientScreen(),
            );
          },
        );
      case '/addDoctor':
        return MaterialPageRoute(
          builder: (context) {
            return BlocProvider<GetDoctorBloc>(
              create: (context) => getIt<GetDoctorBloc>(),
              child: const AddDoctorScreen(),
            );
          },
        );

      // case '/regist_Patient':
      //   final args = routeSettings.arguments as GetPatientBloc;
      //   return MaterialPageRoute(
      //     builder: (context) {
      //       return RegistScreen(
      //         PatientBLoc: args,
      //       );
      //     },
      //   );

      case '/bloodPressureScreen':
        return MaterialPageRoute(
          builder: (context) {
            return MultiBlocProvider(providers: [
              BlocProvider<OCRScannerBloc>(
                create: (context) => getIt<OCRScannerBloc>(),
              )
            ], child: const BloodPressureReadingScreen());
          },
        );
      case '/bloodGlucoseScreen':
        return MaterialPageRoute(
          builder: (context) {
            return MultiBlocProvider(providers: [
              BlocProvider<OCRScannerBloc>(
                create: (context) => getIt<OCRScannerBloc>(),
              )
            ], child: const BloodGlucoseReadingScreen());
          },
        );
      case '/temperatureScreen':
        return MaterialPageRoute(
          builder: (context) {
            return MultiBlocProvider(providers: [
              BlocProvider<OCRScannerBloc>(
                create: (context) => getIt<OCRScannerBloc>(),
              )
            ], child: const TemperatureReadingScreen());
          },
        );
      case '/spo2Screen':
        return MaterialPageRoute(
          builder: (context) {
            return MultiBlocProvider(providers: [
              BlocProvider<OCRScannerBloc>(
                create: (context) => getIt<OCRScannerBloc>(),
              )
            ], child: const Spo2ReadingScreen());
          },
        );
      case '/bloodPressureHistory':
        final id = routeSettings.arguments as String;

        return MaterialPageRoute(
          builder: (context) {
            return MultiBlocProvider(providers: [
              BlocProvider(
                create: (context) => getIt<HistoryBloc>(),
              )
            ], child: BloodPressureHistoryScreen(id: id));
          },
        );
      case '/bloodSugarHistory':
        final id = routeSettings.arguments as String;
        return MaterialPageRoute(
          builder: (context) {
            return MultiBlocProvider(providers: [
              BlocProvider(
                create: (context) => getIt<HistoryBloc>(),
              )
            ], child: BloodSugarHistoryScreen(id: id));
          },
        );
      case '/temperatureHistory':
        final id = routeSettings.arguments as String;
        return MaterialPageRoute(
          builder: (context) {
            return BlocProvider<HistoryBloc>(
              create: (context) => getIt<HistoryBloc>(),
              child: TemperatureHistoryScreen(id: id),
            );
          },
        );
      case '/spo2History':
        final id = routeSettings.arguments as String;
        return MaterialPageRoute(
          builder: (context) {
            return MultiBlocProvider(providers: [
              BlocProvider(
                create: (context) => getIt<HistoryBloc>(),
              )
            ], child: Spo2HistoryScreen(id: id));
          },
        );
      case '/bloodPressuerDetail':
        final response = routeSettings.arguments as BloodPressureEntity;
        return MaterialPageRoute(
            builder: (context) => BloodPressureDetailScreen(
                  bloodPressureEntity: response,
                ));
      case '/bloodSugarDetail':
        final response = routeSettings.arguments as BloodSugarEntity;
        return MaterialPageRoute(
            builder: (context) => BloodSugarDetailScreen(
                  bloodSugarEntity: response,
                ));
      case '/bodyTemperatureDetail':
        final response = routeSettings.arguments as TemperatureEntity;
        return MaterialPageRoute(
            builder: (context) => TemperatureDetailScreen(
                  temperatureEntity: response,
                ));
      case '/spo2Detail':
        final response = routeSettings.arguments as Spo2Entity;
        return MaterialPageRoute(
            builder: (context) => Spo2DetailScreen(
                  spo2Entity: response,
                ));

      case '/bloodPressuerNotificationReading':
        final response = routeSettings.arguments as Map;
        return MaterialPageRoute(
            builder: (context) => BloodPressureNotificationReadingScreen(
                  notificationEntity: response["notificationEntity"],
                  navigateFromCell: response["navigateFromCell"],
                ));
      case '/bloodSugarNotificationReading':
        final response = routeSettings.arguments as Map;
        return MaterialPageRoute(
            builder: (context) => BloodSugarNotificationReadingScreen(
                  notificationEntity: response["notificationEntity"],
                  navigateFromCell: response["navigateFromCell"],
                ));
      case '/bodyTemperatureNotificationReading':
        final response = routeSettings.arguments as Map;
        return MaterialPageRoute(
            builder: (context) => TemperatureNotificationReadingScreen(
                  notificationEntity: response["notificationEntity"],
                  navigateFromCell: response["navigateFromCell"],
                ));
      case '/spo2NotificationReading':
        final response = routeSettings.arguments as Map;
        return MaterialPageRoute(
            builder: (context) => Spo2NotificationReadingScreen(
                  notificationEntity: response["notificationEntity"],
                  navigateFromCell: response["navigateFromCell"],
                ));

      case '/notification':
        final id = routeSettings.arguments as String?;
        return MaterialPageRoute(
          builder: (context) {
            return BlocProvider<NotificationBloc>(
              create: (context) => getIt<NotificationBloc>(),
              child: NotificationScreen(id: id),
            );
          },
        );

      case '/settingMenu':
        return MaterialPageRoute(builder: (context) {
          return const SettingMenu();
        });
      // case '/patientSetting':
      //   return MaterialPageRoute(builder: (context) {
      //     return const PatientSettingMenu();
      //   });

      case '/settingProfile':
        return MaterialPageRoute(
          builder: (context) {
            return BlocProvider<SettingBloc>(
              create: (context) => getIt<SettingBloc>(),
              child: const SettingProfile(),
            );
          },
        );

      case '/settingLanguage':
        return MaterialPageRoute(
          builder: (context) {
            return const SettingLanguage();
          },
        );
      // case '/settingDrOrRePass':
      //   return MaterialPageRoute(
      //     builder: (context) {
      //       return BlocProvider<SettingBloc>(
      //         create: (context) => getIt<SettingBloc>(),
      //         child: const SettingDrOrRePassword(),
      //       );
      //     },
      //   );
      case '/settingPass':
        return MaterialPageRoute(
          builder: (context) {
            return BlocProvider<SettingBloc>(
              create: (context) => getIt<SettingBloc>(),
              child: const SettingPassword(),
            );
          },
        );

      case '/select':
        return MaterialPageRoute(
          builder: (context) {
            return BlocProvider(
              create: (context) => getIt<OCRScannerBloc>(),
              child: const PickEquipmentScreen(),
            );
          },
        );
      default:
        final id = routeSettings.arguments as String;
        return MaterialPageRoute(
          builder: (context) {
            return BlocProvider<GetPatientBloc>(
              create: (context) => getIt<GetPatientBloc>(),
              child: PatientListScreen(id: id),
            );
          },
        );
    }
  }
}
